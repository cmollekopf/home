#!/bin/bash

PASS=mypassword
curl -X PROPFIND "https://caldav.kolabsys.com/calendars/mollekopf@kolabsys.com/" -H "Depth: 1" -H "Content-Type: application/xml" --user 'mollekopf@kolabsys.com:$PASS' --data-binary @- <<EOF | python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
<propfind xmlns="DAV:">
 <prop xmlns="DAV:">
  <displayname xmlns="DAV:"/>
  <resourcetype xmlns="DAV:"/>
  <owner xmlns="DAV:"/>
  <calendar-color xmlns="http://apple.com/ns/ical/"/>
  <supported-calendar-component-set xmlns="urn:ietf:params:xml:ns:caldav"/>
  <supported-calendar-component-sets xmlns="urn:ietf:params:xml:ns:caldav"/>
  <supported-report-set xmlns="DAV:"/>
  <current-user-privilege-set xmlns="DAV:"/>
  <getctag xmlns="http://calendarserver.org/ns/"/>
 </prop>
</propfind>
EOF


# curl -X PROPFIND "https://caldav.kolabsys.com/principals/mollekopf@kolabsys.com/" -H "Depth: 0" -H "Content-Type: application/xml" --user 'mollekopf@kolabsys.com:DM5KR26F5YWI' --data-binary @- <<EOF | python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
# <propfind xmlns="DAV:">
#  <prop xmlns="DAV:">
#   <calendar-home-set xmlns="urn:ietf:params:xml:ns:caldav"/>
#   <current-user-principal xmlns="DAV:"/>
#   <principal-URL xmlns="DAV:"/>
#   <supported-report-set xmlns="DAV:"/>
#  </prop>
# </propfind>
# EOF

