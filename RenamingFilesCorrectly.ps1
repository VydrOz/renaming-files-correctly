[cultureinfo]::CurrentUICulture = 'en-US'

#variables
$hashPreview = @{}
$e = [char]27
$specialChars = '-#${}()[]+' 		# list of characters to remove
$extension = ".txt"         		# file type to rename

# functions
function pause{ param( [String] $msg ) $null = Read-Host "${msg}" }

function SerializeString {
    param ([string]$str, [string]$ext)
    $rePattern = ($specialChars.ToCharArray() | ForEach-Object { [regex]::Escape($_) }) -join "|"
    $str = $str -replace $rePattern,''      # remove special characters
    $str = $str.Trim() -replace '\s+', '_'  # remove first and last spaces & replace spaces by "_"
    "${str}${ext}"
}

Write-Host "Type of file retrieved : " -NoNewLine
Write-Host -ForegroundColor Blue $extension
Write-Host "Special characters will being removed : " -NoNewLine
Write-Host -ForegroundColor Blue $specialChars
""

# start preview
Write-Host -ForegroundColor Green "Overview of changes"
$files = Get-ChildItem -Path $PSScriptRoot -Filter "*${extension}" |
    Foreach-Object {
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        $newFileName = SerializeString $fileName $extension
        $hashPreview.Add($_.Name, $newFileName)
    }
	
# show preview
$hashPreview | Format-Table @{L='Before';E={"$e[0m$($_.Name)${e}[0m"}; width = 60}, @{L='After';E={"$e[93m$($_.Value)${e}[0m"}; width = 60}

# confirm modifications Y/N
$msg = 'Are you sure you want to rename these files?'
$options = '&Yes', '&No'
$default = 1	# 0=Yes, 1=No
$response = $Host.UI.PromptForChoice('', $msg, $options, $default)

if ($response -eq 0) { # Yes ? start rename process
    $files = Get-ChildItem -Path $PSScriptRoot -Filter "*${extension}" |
    Foreach-Object {
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        $newFileName = SerializeString $fileName $extension
        $_ | Rename-Item -NewName $newFileName
    }
    Write-Host -ForegroundColor Green "Operation completed"
}
else {
    Write-Host -ForegroundColor Orange "Operation canceled"
}

# end
""
pause 'Press any key to exit...'
