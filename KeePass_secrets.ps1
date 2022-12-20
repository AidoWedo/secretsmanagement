#requires -version 1
<#
.SYNOPSIS
  Access Locally Stored Keepass Database for Credentials
.DESCRIPTION
  Access Locally Stored Keepass Database for Credentials
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
# Get password form keepass
  $PathTokeepassDB      = "C:\secrets\TestDatabase.kdbx" # change path to match where your db is
  $KeePassPassword      = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($(read-host -Prompt "Password of KeePASS ($i/3) : " -AsSecureString))
  Connectto-Keepass -PlainPassword $([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($KeePassPassword))  -PathTokeepassDB $PathTokeepassDB 
  $EntryToFind   = "You're entry in Keepass"
# secure Password
  $Passwordfromkeypass = (get-KeePassPassword -PathToDB  $PathTokeepassDB `
                                              -EntryToFind $EntryToFind `
                                              -keepassPassword $([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($KeePassPassword)) ).password | 
                                                Convertto-SecureString -asPlainText -Force

 # Save a user and password to Keepass
 $Entryname     = "testapi" # Change this
 $EntryUsername = "testapi" # Change this
 $entryPassword = "MySuperStrongPassword!1" # Change this
 set-KeePassPassword -PathToDB $PathTokeepassDB `
                     -Entryname $Entryname `
                     -EntryUsername $EntryUsername `
                     -EntryPassword $entryPassword `
                     -EntryURL "testapi.test.com" ` # Change this
                     -EntryNotes "testapi account information" `    # Change this
                     -force `
                     -keepassPassword $([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($KeePassPassword))
 get-KeePassPassword -PathToDB $PathTokeepassDB `
                     -EntryToFind $Entryname `
                     -keepassPassword $([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($KeePassPassword))