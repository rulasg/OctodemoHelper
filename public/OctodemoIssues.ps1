
# Set-MyInvokeCommandAlias -Alias deleteIssue -Command "gh issue delete {number} -R {owner}/{repo} -y"

# function Get-OctodemoIssue {
#     [CmdletBinding()]
#     param()

#     $jsonOutput = gh issue list -R octodemo/bootstrap -A rulasg --json number,url,labels,title
#     $json = $jsonOutput | ConvertFrom-Json

#     $issues = $json | ForEach-Object {
#         [PSCustomObject]@{
#             Title  = $_.title
#             Number = $_.number
#             URL    = $_.url
#             Labels = ($_.labels | ForEach-Object { $_.name }) -join ', '
#         }
#     }
#     return $issues
# } Export-ModuleMember -Function Get-OctodemoIssue

# function Remove-OctodemoIssue {
#     [CmdletBinding(SupportsShouldProcess = $true)]
#     param(
#         [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
#         [int]$Number
#     )

#     process {
#         $params = @{
#             Number = $Number
#             Owner  = $OCTIDEMO_ORG
#             Repo   = $BOOTSTRAP_REPO
#         }

#         if ($PSCmdlet.ShouldProcess("Issue #$Number", "Delete")) {
#             # gh issue delete $Number -R octodemo/bootstrap -y
#             Invoke-MyCommand -Command deleteIssue -Parameters $params
#         }
#     }
# } Export-ModuleMember -Function Remove-OctodemoIssue

