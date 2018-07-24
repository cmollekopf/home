#!/usr/bin/env bash
PASS=`pass kolabsys`
PASS2=`pass kolabnow`
# flatpak run --command=kube org.kolab.kube --keyring '{"{d00932b5-2598-45c7-9a9e-e22492305bef}": {"{896ca217-7786-424c-95fc-6b7f6185d716}": "'"$PASS"'", "{922970c3-d4fa-49d7-a766-d15e8710ee5f}": "'"$PASS"'"}}'
kube --keyring '{"{21042e7e-34f8-45ff-8c17-da43bca976d6}": {"{fe5e538e-7a7b-43cc-aeb9-da18af6818a9}": "'"$PASS"'", "{4cef3758-d978-4b49-a0f6-2e7213c2094d}": "'"$PASS"'"}, "{6dd41dbf-e558-4231-b6df-27fe0a670432}": {"{bb933527-5ab6-41ce-a446-72bec6c0016e}": "'"$PASS2"'", "{b9fe27ec-a3a1-43fe-9f74-90ae49f51aad}": "'"$PASS2"'", "{7cef9051-55ae-49b1-af65-9496e5ed237e}": "'"$PASS2"'"}}'
