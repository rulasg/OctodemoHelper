
Set-MyInvokeCommandAlias -Alias GetString -Command 'Invoke-GetString "{str}"'

function Get-PublicString_integration {
    param (
        [Parameter()][string]$Param1
    )

    $param=@{
        str = $Param1
    }

    $result = Invoke-MyCommand -Command GetString -Parameters $param

    return $result
} Export-ModuleMember -Function Get-PublicString_integration



function Invoke-GetString {
    param (
        [Parameter(Position=0)][string]$Param1
    )

    return ("Invoke string [{0}]" -f $param1)
} Export-ModuleMember -Function Invoke-GetString
