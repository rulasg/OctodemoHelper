    <#
        .SYNOPSIS
        Retrieves open issues from a repository that were created by the current user.
    
        .DESCRIPTION
        This function uses the GitHub CLI to search for open issues in a specified repository
        that were created by the current user.
    
        .PARAMETER Org
        The organization name. Default is 'octodemo'.
    
        .PARAMETER Repo
        The repository name. Default is 'bootstrap'.
    
        .EXAMPLE
        Get-OctodemoIssues -Org 'octodemo' -Repo 'bootstrap'
    #>
    function Get-OctodemoIssues {
        [CmdletBinding()]
        param(
            [string]$Org = "octodemo",
            [string]$Repo = "bootstrap"
        )
        $command = "gh search issues repo:$Org/$Repo author:@me is:open --json title,repository,url"
        $json = Invoke-Expression $command 

        $json | Write-Verbose

        $issues = $json | ConvertFrom-Json -Depth 10

        $ret = $issues | ForEach-Object {
            [PSCustomObject]@{
                Title = $_.title
                Repository = $_.repository.nameWithOwner
                Url = $_.url

            }
        }

        $ret | Write-Verbose

        return $ret

    } Export-ModuleMember -Function 'Get-OctodemoIssues'