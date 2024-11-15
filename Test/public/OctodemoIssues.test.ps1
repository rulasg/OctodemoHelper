# function Test_OctodemoIssues_Dev{


#     $number = 68 ; $owner = "octodemo" ; $repo = "bootstrap"

#     Set-InvokeCommandMock -Alias "gh issue delete $number -R $owner/$repo -y" -Command "echo DELETED_ISSUE_69"

#     $result = Remove-OctodemoRepo -Number 69

#     Assert-AreEqual -Expected "DELETED_ISSUE_69" -Presented $result
# }