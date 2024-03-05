
# Additional

# -- Dynamic Membership via MgGraph (anstelle von AzureAd), 
# > skipped


#  -- Add or Remove M365 from Outlook (via MgGraph PowerShell)
Connect-MgGraph -Scopes "Group.ReadWrite.All" -NoWelcome
#(Find-MgGraphCommand -Command Get-MgGroup).Permissions

#Get-MgGroup
Get-MgBetaGroup
#Get-MgGroup -Filter "DisplayName eq 'Leadership Team'"
#DisplayName                 Id                                   MailNickname
#Sales                       13896087-3e43-4c33-a7c3-e66cd2aa39a9 Sales 
Get-MgBetaGroup -GroupId 13896087-3e43-4c33-a7c3-e66cd2aa39a9 | fl DisplayName,MailNickname,ResourceBehaviorOptions
#$groupid = "13896087-3e43-4c33-a7c3-e66cd2aa39a9"
#((get-MgGroup -GroupId $groupid).AdditionalProperties).resourceBehaviorOptions


## ResourceProvisioningOptions = Team
## "resourceBehaviorOptions":["HideGroupInOutlook"]
#$params = @{ 
#    resourceBehaviorOptions = "HideGroupInOutlook"
#}
#Update-MgGroup -GroupId $groupid -BodyParameter $params # Error
#ToBeFinished


#  -- Add or Remove M365 from Outlook (via Exchange PowerShell)
Connect-ExchangeOnline
Get-UnifiedGroup -Anr "Sales" | fl *Name*, *Hidde*
# Name                                       DisplayName GroupType PrimarySmtpAddress
# Sales_13896087-3e43-4c33-a7c3-e66cd2aa39a9 Sales       Universal Sales@WWLx513762.onmicrosoft.com
Set-UnifiedGroup -Identity Sales_13896087-3e43-4c33-a7c3-e66cd2aa39a9 -HiddenFromExchangeClientsEnabled: $false
##Set-UnifiedGroup -Identity Sales_13896087-3e43-4c33-a7c3-e66cd2aa39a9 -HiddenFromAddressListsEnabled: $false
#Set-UnifiedGroup -Identity Sales_13896087-3e43-4c33-a7c3-e66cd2aa39a9 -HiddenFromExchangeClientsEnabled: $true


