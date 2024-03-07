

# https://learn.microsoft.com/en-us/microsoftteams/turn-off-teams-native-file-upload-policy
# Disconnect-MicrosoftTeams
Connect-MicrosoftTeams

# -- Global
Get-CsTeamsFilesPolicy -Identity Global
#>Identity              : Global
#>NativeFileEntryPoints : Enabled
#>SPChannelFilesTab     : Enabled
#Set-CsTeamsFilesPolicy -Identity Global -NativeFileEntryPoints Disabled

# -- Per User

# https://learn.microsoft.com/en-us/sharepoint/manage-lock-status


#New-CsTeamsFilesPolicy -Identity UserPolicy -NativeFileEntryPoints Disabled
New-CsTeamsFilesPolicy -Identity UserPolicy -SPChannelFilesTab Disabled
#Get-CsOnlineUser | ft Identity, UserPrincipalName
Grant-CsTeamsFilesPolicy  -identity "admin@WWLx513762.onmicrosoft.com" -PolicyName UserPolicy


# ----- SharePoint Site (Read only)

# https://learn.microsoft.com/en-us/sharepoint/manage-lock-status

#[SharePointOnlineManagementShell_24614-12000_en-us.msi]
#> https://www.microsoft.com/en-us/download/details.aspx?id=35588

#Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope AllUsers
#Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable
Import-Module -Name Microsoft.Online.SharePoint.PowerShell
# !!! Do not run in Visual Studio Code !! = Could not load file or assembly ...
#Connect-SPOService -Url https://contoso-admin.sharepoint.com
Connect-SPOService -Url https://WWLx513762-admin.sharepoint.com

Get-SPOSite | ft Url, Owner, StorageQuota, LockState
# https://wwlx513762.sharepoint.com/sites/Sales

Set-SPOSite -Identity "https://wwlx513762.sharepoint.com/sites/Sales" -LockState "Readonly"
#Set-SPOSite -Identity "https://wwlx513762.sharepoint.com/sites/Sales" -LockState "Unlock"

# Set-SPOTenant -NoAccessRedirectUrl 'https://www.contoso.com'
