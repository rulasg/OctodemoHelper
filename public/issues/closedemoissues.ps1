function Remove-OctodemoDemo{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,Position=0)][string]$Url,
        [Parameter(ValueFromPipelineByPropertyName,Position=0)][string]$CodespaceName
    )

    process{

        $command = "gh issue close $Url"
        
        if ($PSCmdlet.ShouldProcess($Command)) {
            $result = Invoke-Expression $command
        }

        $result | Write-Output

        if($CodespaceName){
            if ($PSCmdlet.ShouldProcess($CodespaceName)) {
                Remove-LabCodespace -Name $CodespaceName
            } else {
                Remove-LabCodespace -Name $CodespaceName -WhatIf
            }
        }
        

    }

} Export-ModuleMember -Function Remove-OctodemoDemo