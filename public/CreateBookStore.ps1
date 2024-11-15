function New-OctodemoBookStore{
    [CmdletBinding()]
    param()
    $localPath = $PSScriptRoot

    $bookStoreTemplate = $localPath | Join-Path -ChildPath "tmpl_bookstore_v3.5.md"

    $content = Get-Content -Path $bookStoreTemplate -Raw
    $title = "Demo :: octodemo/automatic-octo-tribble :: bookstore_v3.5"

    # Create an issue on github using gh command with $content as the body

    $issue = gh issue create --title $title --body $content --repo "octodemo/bootstrap"

    return $issue
}

function Get-BookStore{
    [CmdletBinding()]
    param()
    

    # list all issues on octodemo/bootstrap that where created by me

    $data =  gh issue list -R octodemo/bootstrap -A rulasg --json number,url,labels

    foreach($item in $data){

        $issueObject = [PSCustomObject]@{
            Title  = $item.title
            Id     = $item.number
            Url    = $item.url
            Labels = $item.labels.name -join " | "
        }
        $issueObject

    }
}
