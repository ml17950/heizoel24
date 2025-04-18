$heizoel24Url = "https://www.heizoel24.de/api/site/1/prices/history?amount=1000&productId=1&rangeType=1"
$today = Get-Date -Format 'yyyy-MM-dd'

#-

$webResponse = Invoke-RestMethod -Uri $heizoel24Url

$price = $webResponse | Where-Object DateTime -like "$today*" | Select-Object -ExpandProperty Price

if($price) {
	Write-Host "Price for $today is: $price"
} else {
	Write-Host "No price data found for $today"
}
