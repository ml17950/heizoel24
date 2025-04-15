@echo off

:: Format date for today
set dd=%date:~0,2%
set mm=%date:~3,2%
set yyyy=%date:~6,4%
set TODAY=%yyyy%-%mm%-%dd%

:: URL to fetch the JSON
set URL="https://www.heizoel24.de/api/site/1/prices/history?amount=1000&productId=1&rangeType=1"

:: Fetch JSON with curl and store in temp-file
curl -s %URL% > temp_data.json

:: Extract today's price using jq
for /f %%i in ('jq -r "map(select(.DateTime | startswith(\"%TODAY%\"))) | .[0].Price" temp_data.json') do set PRICE=%%i

:: Output result
echo.
if defined PRICE (
	echo Price for %TODAY% is: %PRICE%
) else (
	echo No price data found for %TODAY%
)

:: Cleanup
del temp_data.json >nul 2>&1
