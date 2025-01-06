#!/bin/bash

# count=`curl https://alertmanager-prometheus.apps.ocp04.ait-msp-infra.net/api/v2/alerts | jq 'map(select ( .status.state | contains("active") )) | length'`
count=$(curl https://alertmanager-prometheus.apps.ocp04.ait-msp-infra.net/api/v2/alerts | jq 'map(select ( .status.state | contains("active") )) | map( select( .receivers[] | .name | contains("critical-alerts") )) | length')

if [[ "$count" != "0" ]]; then
    echo "  $count critical alerts are active!"
fi
