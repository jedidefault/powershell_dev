##### TITLE HERE


$filePath = ''
$tempFilePath = "$env:TEMP\$($filePath | Split-Path -Leaf)"
$findip = ''
$replaceip = 'TESTING'

(Get-Content -Path $filePath) -replace $findip, $replaceip | Add-Content -Path $tempFilePath

Remove-Item -Path $filePath
Move-Item -Path $tempFilePath -Destination $filePath