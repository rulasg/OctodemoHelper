
$MODULE_TEST_TAG = "OctodemoModule_Test"

function Set-MockInvokeCommandAlias {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Mock,
        [Parameter(Mandatory = $true)]
        [string]$Command
    )

    Set-InvokeCommandAlias -Mock $Mock -Command $Command -Tag
}