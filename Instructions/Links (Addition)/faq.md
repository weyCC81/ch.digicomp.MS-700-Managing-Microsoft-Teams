# FAQ

### Title

#### PowerShell Snippet

```powershell
Install-Module -Name MicrosoftTeams -Scope AllUsers
Connect-MicrosoftTeams
# Get-TeamHelp
# Get-Command –Module MicrosoftTeams 

# Get-CsOnlineUser -ResultSize Unlimited | Export-Csv "C:\path\to\allusers.csv"
# - DirectRouting
Set-CsPhoneNumberAssignment -Identity $user.UserPrincipalName -PhoneNumber $user.PhoneNumber -PhoneNumberType $user.PhoneNumberType
Grant-CsOnlineVoiceRoutingPolicy -Identity $user.UserPrincipalName -PolicyName $user.VoiceRoutingPolicy
# Source: https://github.com/microsoft/FastTrack/tree/master/samples/teams-phonesystem-snippets
Disconnect-MicrosoftTeams

Install-Module Microsoft.Graph -Scope AllUsers
#Install-Module Microsoft.Graph.Beta -Scope AllUsers
Connect-MgGraph -ContextScope Process
#Find-MgGraphCommand -Command *SettingTemplate*

```


