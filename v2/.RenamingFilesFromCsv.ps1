[globalization.cultureinfo]::CurrentUICulture = 'en-US'

# variables
$csvFileName = "Files_To_Rename.csv"
$csvFile = Import-Csv -Path "${PSScriptRoot}\${csvFileName}" -Delimiter ";" -Header FileName,NewFileName 

# functions
function pause { param( [String] $msg ) $null = Read-Host "${msg}" }

Write-Host -ForegroundColor Yellow "/!\ Warning : Make sure than the extension (e.g: '.pdf') is indicated in the File Name and New File Name"
""
Write-Host "CSV File Name : " -NoNewLine
Write-Host -ForegroundColor Blue $csvFileName
Write-Host "Current Path : " -NoNewLine
Write-Host -ForegroundColor Blue $PSScriptRoot

""
pause 'Press Enter to start renaming process from the csv file specified'
""

# skip row header and read csv
$csvFile | Select-Object -Skip 1  | Foreach-Object {
   try {
	   $f = $_.FileName
	   $successMsg = "Rename successfully : {0} -> {1}`n" -f $_.FileName, $_.NewFileName
	   Rename-Item -LiteralPath $PSScriptRoot/$f $_.NewFileName -ErrorAction 'Stop'
	   Write-Host -ForegroundColor Green $successMsg
   }
   catch {
	   Write-Host -ForegroundColor Red "File '${f}'"
	   Write-Host -ForegroundColor Red "  Error : $_ `n"
   }
}

# end
""
pause 'Press Enter to exit...'