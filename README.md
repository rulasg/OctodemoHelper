# OctodemoHelper

A powershell module that will hold Powershell functionality.

## Use cases

### Create a Octodemo project issue

Use bootstrap template to create a new issue in the Octodemo project.
We have not created automation to create a new issue in the Octodemo project yet.

### List Octodemo project issues

List all issues in the Octodemo project.

```powershell
> Get-OctodemoDemos

Title      : Demo :: octodemo/animated-octo-carnival :: copilot_nodejs_basic_v1.5
Repository : octodemo/bootstrap
Url        : https://github.com/octodemo/bootstrap/issues/1086
Repo       : octodemo/animated-octo-carnival
RepoUrl    : https://github.com/octodemo/animated-octo-carnival
Labels     : template , demo , demo::provisioned
```
### Create Codespaces for each demo

Create a Codespace for each demo in the Octodemo project.

```powershell
> Get-OctodemoDemos | New-LabCodespace
  ✓ Codespaces usage for this repository is paid for by octodemo
```
### Check if the octodemo demos have a Codespace

Check if the octodemo demos have a Codespace.

```powershell
> Get-OctodemoDemos -codespacesInfo

Title                : Demo :: octodemo/animated-octo-carnival :: copilot_nodejs_basic_v1.5
Repository           : octodemo/bootstrap
Url                  : https://github.com/octodemo/bootstrap/issues/1086
Repo                 : octodemo/animated-octo-carnival
RepoUrl              : https://github.com/octodemo/animated-octo-carnival
Labels               : template , demo , demo::provisioned
CodespaceDisplayName : redesigned waffle
CodespaceName        : redesigned-waffle-gwrv5v5vvxcvv5g
```
### Remove Octodemo demo issues

Remove all issues in the Octodemo issue to destroy the demos.

```powershell
Get-OctodemoDemos | Remove-OctodemoDemo
```

This command will close the issue to have the demo removed and removes the Codespace associated with the demo.

> Module generated with [TestingHelper Powershell Module](https://www.powershellgallery.com/packages/TestingHelper/)
