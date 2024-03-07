# FAQ

## Teams Licensing

### Microsoft 365 Licensing

- <https://m365maps.com/>
- <https://m365maps.com/matrix.htm#111111000001111000000>
- <https://m365maps.com/files/Microsoft-Teams-Premium.htm>

### Complete Office 365 and Microsoft 365 Licensing Comparison

- <https://www.infusedinnovations.com/blog/secure-modern-workplace/complete-office-365-and-microsoft-365-licensing-comparison>

## Network Test

- <https://connectivity.office.com>

> Sign in (Download and Run Agent for Extended Report)

## Guest User vs External User

B2B Collaboration = Guest User
B2B Direct Connect = External User

## Restrict Team (Groups) to Join Guests

- AllowToAddGuests
see [path2_graph-guest_optional.ps1]

## Safe Links (Test, Validation)

> Decode SafeLink URL
<https://www.o365atp.com/>

## Retention "Apply or remove encryption" not available
>
> not available
<https://techcommunity.microsoft.com/t5/healthcare-and-life-sciences/microsoft-purview-paint-by-numbers-series-part-2g-recommended/ba-p/3846835>

## Calling Plan

### Calling Plan (Optional) - US

Contoso Emergency Address
> 1 Microsoft Way, Redmond, WA 98052  
> 1 NE One Microsoft Way, Redmond WA 98052, US, --> did not work

Contoso United States Emergency Address
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

### Calling Plan (Optional) - CH

Contoso Schweiz Emergency Address
> Microsoft Schweiz GmbH
> Talstrasse 9, 5037 Muhen
> Talstrasse 9, Muhen Aargau, 5037, CH, --> you will be contacted by Microsoft (PSTN)

### Resource Account license allocation

<https://learn.microsoft.com/en-us/microsoftteams/teams-add-on-licensing/virtual-user>

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

### Entra Export (Backup)

<https://github.com/microsoft/EntraExporter>
<https://office365itpros.com/2023/08/24/entraexporter-tool/>

```powershell
Install-Module EntraExporter -Scope Allusers

Connect-MgGraph -Scopes 'Directory.Read.All', 'User.Read.All'
Connect-EntraExporter
#Export-Entra -Path 'C:\EntraID\' -All
#Export-Entra -Path 'C:\EntraBackup\' -All -CloudUsersAndGroupsOnly
Export-Entra -Path 'C:\EntraBackup\' -Type "Groups"

#(Get-Command Export-Entra | Select-Object -Expand Parameters)['Type'].Attributes.ValidValues
```

### Dynamic Membership via MgGraph (anstelle von AzureAD)

> skipped

### Add or Remove M365 from Outlook (via PowerShell)

> "resourceBehaviorOptions":["HideGroupInOutlook"]  
Source: <https://office365itpros.com/2022/03/29/create-entra-id-group/>

### Temporary recodring storage (upload failed)

> 21 Days

- <https://learn.microsoft.com/en-us/microsoftteams/meeting-recording?tabs=meeting-policy#temporary-storage-when-unable-to-upload-to-onedrive-and-sharepoint>

### Voice routing policies (PSTN usage records)

PSTN usage records define which calling plans or phone numbers users are allowed to use for making outbound calls. When configuring voice routing policies, administrators can assign PSTN usage records to specify the phone numbers or calling plans that users can access for making calls outside the organization.


### Teams Cache (Classic vs New)

- <https://learn.microsoft.com/en-us/microsoftteams/troubleshoot/teams-administration/clear-teams-cache>

Classic Teams Folder: %appdata%\Microsoft\Teams
New Teams: Programme > Teams > Advanced > Reset (instead of uninstall and re-install)
New Teams Folder: %localappdata%\Packages\MSTeams_8wekyb3d8bbwe


### Teams


### OneDrive Backup
>
> *Backup important PC folders to OneDrive*
> OneDrive Backup is a cloud storage service by Microsoft that automatically backs up and syncs files from devices to the cloud, ensuring data safety and accessibility.

<https://support.microsoft.com/de-de/office/aktivieren-von-onedrive-backup-4e44ceab-bcdf-4d17-9ae0-6f00f6080adb>

# Limit Files & OneDrive

- Disable Files Tab in Teams: https://learn.microsoft.com/en-us/microsoftteams/turn-off-teams-native-file-upload-policy
- Setup policies (remove OneDrive)
- Read only for SharePoint Site (Teams): https://learn.microsoft.com/en-us/sharepoint/manage-lock-status
