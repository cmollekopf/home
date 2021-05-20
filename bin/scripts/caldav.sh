#!/bin/bash

USER=test1@kolab.org
AUTH="test1@kolab.org:Welcome2KolabSystems"

#List principals
curl --user $AUTH -sD /dev/stderr -H "Content-Type: application/xml" -X PROPFIND -H "Depth: infinity" --data '<d:propfind xmlns:d="DAV:" xmlns:cs="https://calendarserver.org/ns/"><d:prop><d:resourcetype /><d:displayname /></d:prop></d:propfind>' https://apps.kolabnow.com/principals/$USER | xmllint -format -

#List calendars
curl --user $AUTH -sD /dev/stderr -H "Content-Type: application/xml" -X PROPFIND -H "Depth: infinity" --data '<d:propfind xmlns:d="DAV:" xmlns:cs="https://calendarserver.org/ns/"><d:prop><d:resourcetype /><d:displayname /></d:prop></d:propfind>' https://apps.kolabnow.com/calendars/$USER | xmllint -format -


#List events
CALENDAR="6f552d35-95c4-41f6-a7d2-cfd02dd867db"
curl --user $AUTH -sD /dev/stderr -H "Content-Type: application/xml" -X PROPFIND -H "Depth: infinity" https://apps.kolabnow.com/calendars/$USER/$CALENDAR/ | xmllint -format -

#List Event
EVENT="%7bb6386411-abeb-48c8-8d27-890009cbe8ee%7d.ics"
curl --user $AUTH -sD /dev/stderr -H "Content-Type: application/xml" -X PROPFIND -H "Depth: infinity" https://apps.kolabnow.com/calendars/$USER/$CALENDAR/$EVENT | xmllint -format -

#List Event content
EVENT="%7bb6386411-abeb-48c8-8d27-890009cbe8ee%7d.ics"
curl --user $AUTH -sD /dev/stderr -H "Content-Type: application/xml" -X REPORT -H "Depth: infinity" --data '<c:calendar-query xmlns:d="DAV:" xmlns:c="urn:ietf:params:xml:ns:caldav" xmlns:cs="https://calendarserver.org/ns/"><d:prop><d:getetag /><c:calendar-data /></d:prop></c:calendar-query>' https://apps.kolabnow.com/calendars/$USER/$CALENDAR/$EVENT | xmllint -format -


# PASS=mypassword
# curl -X PROPFIND "https://caldav.kolabsys.com/calendars/mollekopf@kolabsys.com/" -H "Depth: 1" -H "Content-Type: application/xml" --user 'mollekopf@kolabsys.com:$PASS' --data-binary @- <<EOF | python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
# <propfind xmlns="DAV:">
#  <prop xmlns="DAV:">
#   <displayname xmlns="DAV:"/>
#   <resourcetype xmlns="DAV:"/>
#   <owner xmlns="DAV:"/>
#   <calendar-color xmlns="http://apple.com/ns/ical/"/>
#   <supported-calendar-component-set xmlns="urn:ietf:params:xml:ns:caldav"/>
#   <supported-calendar-component-sets xmlns="urn:ietf:params:xml:ns:caldav"/>
#   <supported-report-set xmlns="DAV:"/>
#   <current-user-privilege-set xmlns="DAV:"/>
#   <getctag xmlns="http://calendarserver.org/ns/"/>
#  </prop>
# </propfind>
# EOF


# # curl -X PROPFIND "https://caldav.kolabsys.com/principals/mollekopf@kolabsys.com/" -H "Depth: 0" -H "Content-Type: application/xml" --user 'mollekopf@kolabsys.com:DM5KR26F5YWI' --data-binary @- <<EOF | python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
# # <propfind xmlns="DAV:">
# #  <prop xmlns="DAV:">
# #   <calendar-home-set xmlns="urn:ietf:params:xml:ns:caldav"/>
# #   <current-user-principal xmlns="DAV:"/>
# #   <principal-URL xmlns="DAV:"/>
# #   <supported-report-set xmlns="DAV:"/>
# #  </prop>
# # </propfind>
# # EOF

