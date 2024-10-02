# ------Addition
# Prevent guests from being added to a specific Microsoft 365 group or Microsoft Teams team

# Dokumentation: https://learn.microsoft.com/en-us/microsoft-365/solutions/per-group-guest-access?view=o365-worldwide

# Part 1 (Change)

# Install-Module Microsoft.Graph.Beta -Scope AllUsers
# Connect-MgGraph
Connect-MgGraph -ContextScope Process -Scopes "Directory.ReadWrite.All" -NoWelcome

$GroupName = "<GroupName>"
$templateId = (Get-MgBetaDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}).Id
$groupID = (Get-MgBetaGroup -Filter "DisplayName eq '$GroupName'").Id

$params = @{
	templateId = "$templateId"
	values = @(
		@{
			name = "AllowToAddGuests"
			value = "false"
		}
	)
}
New-MgBetaGroupSetting -GroupId $groupID -BodyParameter $params

# Part 2 (Verify)

(Invoke-GraphRequest -Uri https://graph.microsoft.com/beta/Groups/$groupId/settings -Method GET) | ConvertTo-Json | ConvertFrom-Json | fl Value
(Get-MgBetaGroupSetting -GroupId $groupId | Where-Object { $_.DisplayName -eq "Group.Unified.Guest"}).Values
# name = "AllowToAddGuests" value = "false"
