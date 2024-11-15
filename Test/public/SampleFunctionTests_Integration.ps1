function Test_GetPublicString_Integration{

    Reset-InvokeCommandMock

    $str = "test"
    $command = 'Invoke-GetString "{str}"'
    $command = $command -replace "{str}", $str

    MockCallToString -Command $command -OutString "test"

    $result = Get-PublicString_integration -Param1 "test"

    Assert-AreEqual -Expected $str -Presented $result
} 