# Gate to be loaded only onces
if (! $LOADED_EARLYLOADED){
    $LOADED_EARLYLOADED = $true

    # Add all modules that requies to be loadd before the code modules.
    # This is useful when you have a dependency to run


    # Load Invoke helper functions
    . $(($PSScriptRoot | Join-Path -ChildPath SetMyInvokeCommandAlias.ps1 | Get-Item).FullName)
    . $(($PSScriptRoot | Join-Path -ChildPath InvokeHelper_Globals.ps1 | Get-Item).FullName)

}

