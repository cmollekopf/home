#!/bin/bash

count=`curl https://alertmanager-prometheus.apps.ocp04.ait-msp-infra.net/api/v1/alerts | jq '.data | map(select ( .status.state | contains("active") )) | length'`

if [[ "$count" != "1" ]]; then
    echo "  Alerts are active!"
fi
