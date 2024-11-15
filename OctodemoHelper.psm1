
$MODULE_PATH = $PSScriptRoot

# Import START
$START = $MODULE_PATH | Join-Path -ChildPath "private" -AdditionalChildPath 'START.ps1'
if($START | Test-Path){ . $($START | Get-Item).FullName }

#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $MODULE_PATH\public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $MODULE_PATH\private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}