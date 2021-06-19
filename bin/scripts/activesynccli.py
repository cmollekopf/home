#!/bin/env python3

"""
activesynccli.py
    --host apps.kolabnow.com
    --user test1@kolab.org
    --password Welcome2KolabSystems
"""

import argparse
import base64
import http.client
import urllib.parse
import wbxml
import struct
import xml.etree.ElementTree as ET

def http_request(url, method, params=None, headers=None, body=None):
    """
        Perform an HTTP request.
    """

    # print(url)
    parsed_url = urllib.parse.urlparse(url)
    # print("Connecting to ", parsed_url.netloc)
    if url.startswith('https://'):
        conn = http.client.HTTPSConnection(parsed_url.netloc, 443)
    else:
        conn = http.client.HTTPConnection(parsed_url.netloc, 80)

    if params is None:
        params = {}

    if headers is None:
        headers = {
            "Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
        }

    if body is None:
        body = urllib.parse.urlencode(params)

    # print("Requesting", parsed_url.geturl(), "From", parsed_url.netloc)
    conn.request(method, parsed_url.geturl(), body, headers)
    response = conn.getresponse()

    # Handle redirects
    if response.status in (301, 302,):
        # print("Following redirect ", response.getheader('location', ''))
        return http_request(
            urllib.parse.urljoin(url, response.getheader('location', '')),
            method,
            params,
            headers,
            body)

    if not response.status == 200:
        print("  ", "Status", response.status)
        print("  ", response.read().decode())

    return response


def basic_auth_headers(username, password):
    user_and_pass = base64.b64encode(
        f"{username}:{password}".encode("ascii")
    ).decode("ascii")

    return {
        "Authorization": "Basic {}".format(user_and_pass)
    }


def try_get(name, url, verbose, headers = None, body = None):
    response = http_request(
        url,
        "GET",
        None,
        headers,
        body
    )
    success = response.status == 200
    if not success:
        print(f"=> Error: {name} is not available")

    if verbose or not success:
        print("  ", "Status", response.status)
        print("  ", response.read().decode())

    return success


def test_autodiscover_activesync(host, username, password, verbose = False):
    body = '''<Autodiscover \
xmlns="http://schemas.microsoft.com/exchange/autodiscover/mobilesync/requestschema/2006">
    <Request>
      <EMailAddress>{username}</EMailAddress>
      <AcceptableResponseSchema>
         http://schemas.microsoft.com/exchange/autodiscover/mobilesync/responseschema/2006
       </AcceptableResponseSchema>
    </Request>
</Autodiscover>'''

    headers = {
        "Content-Type": "text/xml; charset=utf-8"
    }

    response = http_request(
        f"https://{host}/autodiscover/autodiscover.xml",
        "POST",
        None,
        headers,
        body
    )

    success = response.status == 200
    data = response.read().decode()
    if not success:
        print("=> Error: Activesync autodiscover is not available")
    else:
        # Sanity check of the data
        assert f"<Url>https://{host}/Microsoft-Server-ActiveSync</Url>" in data
        assert username in data

    if verbose or not success:
        print("  ", "Status", response.status)
        print("  ", data)

    return success


def test_activesync(host, username, password, verbose = False):
    headers = {
        "Host": host,
        **basic_auth_headers(username, password)
    }

    response = http_request(
        f"https://{host}/Microsoft-Server-ActiveSync",
        "OPTIONS",
        None,
        headers,
        None
    )

    success = response.status == 200
    data = response.read().decode()
    if not success:
        print("=> Error: Activesync is not available")
    else:
        # Sanity check of the data
        assert response.getheader('MS-Server-ActiveSync', '')
        assert '14.1' in response.getheader('MS-ASProtocolVersions', '')
        assert 'FolderSync' in response.getheader('MS-ASProtocolCommands', '')

    if verbose or not success:
        print("  ", "Status", response.status)
        print("  ", data)

    return success


class ActiveSync:
    def __init__(self, options):
        self.host = options.host
        self.username = options.username
        self.password = options.password
        self.verbose = options.verbose

        if options.deviceid:
            self.deviceid = options.deviceid
        else:
            self.deviceid = 'v140Device'

        if options.devicetype:
            self.devicetype = options.devicetype
        else:
            self.devicetype = 'iphone'

        if options.folder:
            self.folder = options.folder
        else:
            self.folder = None


    def send_request(self, command, request):
        body = wbxml.xml_to_wbxml(request)

        headers = {
            "Host": self.host,
            **basic_auth_headers(self.username, self.password)
        }

        headers.update(
            {
                "Content-Type": "application/vnd.ms-sync.wbxml",
                'MS-ASProtocolVersion': "14.0",
            }
        )

        return http_request(
            f"https://{self.host}/Microsoft-Server-ActiveSync?Cmd={command}&User={self.username}&DeviceId={self.deviceid}&DeviceType={self.devicetype}",
            "POST",
            None,
            headers,
            body
        )


    def check(self):
        headers = {
            "Host": self.host,
            **basic_auth_headers(self.username, self.password)
        }

        response = http_request(
            f"https://{self.host}/Microsoft-Server-ActiveSync",
            "OPTIONS",
            None,
            headers,
            None
        )

        success = response.status == 200
        data = response.read().decode()
        if not success:
            print("=> Error: Activesync is not available")
        else:
            # Sanity check of the data
            assert response.getheader('MS-Server-ActiveSync', '')
            assert '14.1' in response.getheader('MS-ASProtocolVersions', '')
            assert 'FolderSync' in response.getheader('MS-ASProtocolCommands', '')

        if self.verbose or not success:
            print("  ", "Status", response.status)
            print("  ", data)

        return success


    def fetch(self, collection_id, sync_key = 0):
        request = """
        <?xml version="1.0" encoding="utf-8"?>
        <!DOCTYPE AirSync PUBLIC "-//AIRSYNC//DTD AirSync//EN" "http://www.microsoft.com/">
        <Sync xmlns="uri:AirSync" xmlns:AirSyncBase="uri:AirSyncBase">
            <Collections>
                <Collection>
                    <SyncKey>{sync_key}</SyncKey>
                    <CollectionId>{collection_id}</CollectionId>
                    <DeletesAsMoves>0</DeletesAsMoves>
                    <DeletesAsMoves>0</DeletesAsMoves>
                    <WindowSize>512</WindowSize>
                    <Options>
                        <FilterType>0</FilterType>
                        <MIMESupport>2</MIMESupport>
                        <MIMETruncation>8</MIMETruncation>
                        <BodyPreference xmlns="uri:AirSyncBase">
                            <Type>4</Type>
                            <AllOrNone>1</AllOrNone>
                        </BodyPreference>
                    </Options>
                </Collection>
            </Collections>
            <WindowSize>512</WindowSize>
        </Sync>
        """.replace('    ', '').replace('\n', '')

    # for mail
        # <BodyPreference xmlns="uri:AirSyncBase">
        #     <Type>4</Type>
        response = self.send_request('Sync', request.format(collection_id=collection_id, sync_key=sync_key))

        assert response.status == 200

        result = wbxml.wbxml_to_xml(response.read())

        if self.verbose:
            print(result)

        root = ET.fromstring(result)
        xmlns = "http://synce.org/formats/airsync_wm5/airsync"
        sync_key = root.find(f".//{{{xmlns}}}SyncKey").text
        more_available = (len(root.findall(f".//{{{xmlns}}}MoreAvailable")) == 1)
        if self.verbose:
            print("Current SyncKey:", sync_key)

        for add in root.findall(f".//{{{xmlns}}}Add"):
            serverId = add.find(f"{{{xmlns}}}ServerId").text
            print("  ServerId", serverId)
            applicationData = add.find(f"{{{xmlns}}}ApplicationData")

            calxmlns = "http://synce.org/formats/airsync_wm5/calendar"
            subject = applicationData.find(f"{{{calxmlns}}}Subject")
            print("  Subject", subject.text)
            startTime = applicationData.find(f"{{{calxmlns}}}StartTime")
            print("  StartTime", startTime.text)
            timeZone = applicationData.find(f"{{{calxmlns}}}TimeZone")
            if timeZone is not None:
                #the dates are encoded like so: vstdyear/vstdmonth/vstdday/vstdweek/vstdhour/vstdminute/vstdsecond/vstdmillis
                decoded = base64.b64decode(timeZone.text)
                bias, standardName, standardDate, standardBias, daylightName, daylightDate, daylightBias = struct.unpack('i64s16si64s16si', decoded)
                print(f"  TimeZone bias: {bias}min")
            print("")


        print("\n")

        # Fetch after the initial sync
        if sync_key == "1":
            self.fetch(collection_id, sync_key)

        # Fetch more
        if more_available:
            self.fetch(collection_id, sync_key)



    def list(self):
        request = """
            <?xml version="1.0" encoding="utf-8"?>
            <!DOCTYPE ActiveSync PUBLIC "-//MICROSOFT//DTD ActiveSync//EN" "http://www.microsoft.com/">
            <FolderSync xmlns="FolderHierarchy:">
                <SyncKey>0</SyncKey>
            </FolderSync>
        """.replace('    ', '').replace('\n', '')

        response = self.send_request('FolderSync', request)

        assert response.status == 200

        result = wbxml.wbxml_to_xml(response.read())

        if self.verbose:
            print(result)

        root = ET.fromstring(result)
        xmlns = "http://synce.org/formats/airsync_wm5/folderhierarchy"
        sync_key = root.find(f".//{{{xmlns}}}SyncKey").text
        if self.verbose:
            print("Current SyncKey:", sync_key)

        for add in root.findall(f".//{{{xmlns}}}Add"):
            displayName = add.find(f"{{{xmlns}}}DisplayName").text
            serverId = add.find(f"{{{xmlns}}}ServerId").text
            print("ServerId", serverId)
            print("DisplayName", displayName)

            if self.folder and displayName == self.folder:
                self.fetch(serverId)

# response = http_request(
#     f"https://{host}/autodiscover/autodiscover.xml",
#     "POST",
#     None,
#     headers,
#     body
# )




def main():
    parser = argparse.ArgumentParser("usage: %prog [options]")
    subparsers = parser.add_subparsers()

    parser.add_argument("--host", help="Host")
    parser.add_argument("--username", help="Output directory")
    parser.add_argument("--password", help="User password to use for all files")
    parser.add_argument("--verbose", action='store_true', help="Verbose output")
    parser.add_argument("--deviceid", action='store_true', help="deviceid")
    parser.add_argument("--devicetype", action='store_true', help="devicetype")

    parser_list = subparsers.add_parser('list')
    parser_list.add_argument("--folder", help="Folder")
    parser_list.set_defaults(func=lambda args: ActiveSync(args).list())

    parser_check = subparsers.add_parser('check')
    parser_check.set_defaults(func=lambda args: ActiveSync(args).check())

    options = parser.parse_args()

    options.func(options)

    # if test_autodiscover_activesync(options.host, options.username, options.password, options.verbose):
    #     print("=> Activesync Autodsicovery available")

    # if test_activesync(options.host, options.username, options.password, options.verbose):
    #     print("=> Activesync available")



if __name__ == "__main__":
    main()
