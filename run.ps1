# .\run.ps1
$PWD = Get-Location

processing-java --sketch=$PWD --run

Read-Host -Prompt "Pressiona Enter para sair"