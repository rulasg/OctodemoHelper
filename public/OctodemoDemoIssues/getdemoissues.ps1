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
        Get-DemoIssues -Org 'octodemo' -Repo 'bootstrap'
    #>
    function Get-DemoIssues {
        [CmdletBinding()]
        param(
            [string]$Org = "octodemo",
            [string]$Repo = "bootstrap"
        )
        $command = "gh search issues repo:$Org/$Repo author:@me is:open"
        Invoke-Expression $command
    } Export-ModuleMember -Function 'Get-DemoIssues'