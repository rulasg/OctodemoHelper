$MODULE_TAG = "OctodemoModule"

function Set-MyInvokeCommandAlias {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Alias,
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    Set-InvokeCommandAlias -Alias $Alias -Command $Command -Tag $MODULE_TAG
}