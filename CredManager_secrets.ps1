#requires -version 1
<#
.SYNOPSIS
  Access Locally Stored Credential Manager Secrets
.DESCRIPTION
  Access Locally Stored Credential Manager Secrets
.PARAMETER <Parameter_Name>
    None
.INPUTS
  None
.OUTPUTS
  Logging to a log file at C:\log
.NOTES
  Version:        1.0
  Author:         Richard B
  Creation Date:  20/12/2022 (UK FORMAT)
  Purpose/Change: Initial script development
  Credits: https://d2c-it.nl/2019/12/03/powershell-passwords
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>

.TODO
 Choose what logging to use not both application and output to dile
#>## 

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'
$RequireScriptVersion = '1.0'

# Powershell Version

$versionMinimum = '7.1'

#----------------------------------------------------------[Script]----------------------------------------------------------#

# Date and time for logging
$Date = Get-Date -Format "dddd MM/dd/yyyy HH:mm K"

# Logging Function
# $Logfile = "C:\Path\to\Logs\$$(gc env:computername).log"
$Logfile = "C:\Logs\$(Get-Content env:computername).log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}
# Install and download the CredentialManager PowerShell Module
Install-Module -name CredentialManager

# Create New Credentials

New-StoredCredential -Target Administrator -UserName testapi -Password "MySuperStrongPassword!1"

# Get Credential

$Credential = Get-StoredCredential -Target testapi

# Get Credential as Plaintext

$Plaintext = (Get-StoredCredential -Target testapi -AsCredentialObject).Password

# get all saved Credential

Get-StoredCredential 

# Remove Credential

Remove-StoredCredential -Target testapi