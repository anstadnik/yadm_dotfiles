#!/bin/sh
CONTENT=$(curl -Ls https://freegeoip.app/json/)
echo $CONTENT
longitude=$(echo $CONTENT | jq .longitude)
latitude=$(echo $CONTENT | jq .latitude)
echo $longitude $latitude
wlsunset -l $latitude -L $longitude
