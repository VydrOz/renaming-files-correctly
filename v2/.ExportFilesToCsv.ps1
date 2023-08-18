[globalization.cultureinfo]::CurrentUICulture = 'en-US'

# variables
$extension = ".txt"		# file type to export
$csvExportFileName = "Files_To_Rename.csv"

# functions
function pause { param( [String] $msg ) $null = Read-Host "${msg}" }

Write-Host "Extension : " -NoNewLine
Write-Host -ForegroundColor Blue $extension
Write-Host "CSV export file name : " -NoNewLine
Write-Host -ForegroundColor Blue $csvExportFileName
""
Write-Host -ForegroundColor Green "Extraction start..."
""

# extract files + preview
$files = @()
Get-ChildItem -Path $PSScriptRoot -Filter "*${extension}" |
    Foreach-Object {
        $fileName = [System.IO.Path]::GetFileName($_.Name)
		Write-Host -ForegroundColor Gray "  "([char]0x2514+[char]0x2500)$fileName
		$files += [pscustomobject]@{"Actual file name"=$fileName;"New file name"=""}
    }

# export files to CSV
$files | Export-Csv -Path .\$csvExportFileName -Delimiter ';' -NoTypeInformation

# end
""
Write-Host -ForegroundColor Green "Extraction complete"
""
pause "Press any key to exit..."