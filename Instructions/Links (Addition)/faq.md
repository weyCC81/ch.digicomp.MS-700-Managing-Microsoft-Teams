# FAQ

### Title

### Calling Plan (Optional) - US

Contoso Emergency Address
> 1 Microsoft Way, Redmond, WA 98052
> 1 NE One Microsoft Way, Redmond WA 98052, US, --> did not work

Contoso  United States Emergency Address
> One Microsoft Way, Redmond, WA 98052, Vereinigte Staaten
> 1 NE One Microsoft Way, Redmond WA 98052, US, --> did not work?

### Calling Plan (Optional) - CA


Contoso Canada Emergency Address
> Microsoft Canada
> 2640 Bd Laurier Microsoft, Québec, QC G1V 5C2, Kanada
> 2640 Boulevard Laurier, Québec QC G1V 4M6, CA, --> worked



**Get numbers**
Get phone number support
Review your information displayed below. If everything looks good, submit your order. We'll let you know when your numbers are ready to go, or if there are any issues.

**Requested:**
Country or region: Canada
Number usages: User
Area code: 581
Location: Contoso
Quantity: 1
Reserved numbers: +1 581 702 4097

### Resource Account license allocation

https://learn.microsoft.com/en-us/microsoftteams/teams-add-on-licensing/virtual-user

Your organization is allotted Teams Phone Resource Account licenses based on its overall size. Any organization that has a subscription with Phone System features, such as Teams Phone Standard, Teams Phone with Calling Plan, and Teams Shared Devices licenses, is <mark>allocated 25 Teams Phone Resource Account licenses available at no cost</mark>.

For <mark>every 10 user</mark> licenses of Teams Phone Standard, Teams Phone with Calling Plan, or devices with Teams Shared Devices license in your organization, <mark>one more Teams Phone Resource Account license becomes available</mark>. Most organizations will have enough Teams Phone Resource Account licenses based on this scaling plan.



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


