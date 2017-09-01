#The remote nuget server name in local
$nugetName = "LiveConversation"
#The nuget path which also include the credential management tool (Get from VSO package feed setting)
$nugetExePath = "C:\Personal\Code\GitRepo\xycui\LiveConversation\Nuget\NuGet.exe"
#The folder which contain the nuget packages need to be uploaded
$packageFolder = "C:\Users\xiacui\Desktop\Nugets"
Get-ChildItem $packageFolder |
ForEach-Object{
   $argument = 'push -Source "{0}" -ApiKey VSTS {1}' -f $nugetName,$_.FullName
   Write-Host $argument

   $pinfo = New-Object System.Diagnostics.ProcessStartInfo
   $pinfo.FileName = $nugetExePath
   $pinfo.RedirectStandardError = $true
   $pinfo.RedirectStandardOutput = $true
   $pinfo.UseShellExecute = $false
   $pinfo.Arguments = $argument

   $proc = New-Object System.Diagnostics.Process
   $proc.StartInfo = $pinfo
   $proc.Start() | Out-Null
   $proc.WaitForExit()

   Write-Host $proc.StandardOutput.ReadToEnd()
   Write-Host $proc.StandardError.ReadToEnd()
}
