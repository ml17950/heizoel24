#!/bin/bash

# URL to fetch the JSON
url="https://www.heizoel24.de/api/site/1/prices/history?amount=1000&productId=1&rangeType=1"

# Fetch JSON with curl and store in variable
json_data=$(curl -s "$url")

# Get today's date in the required format
today=$(date '+%Y-%m-%d')

# Extract today's price using jq
price=$(echo "$json_data" | jq -r --arg today "$today" '.[] | select(.DateTime | startswith($today)) | .Price')

# Output result
echo
if [ -n "$price" ]; then
  echo "Price for $today is: $price"
else
  echo "No price data found for $today"
fi
