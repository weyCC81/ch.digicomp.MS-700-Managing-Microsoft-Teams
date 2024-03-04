# ------Addition
# Prevent guests from being added to a specific Microsoft 365 group or Microsoft Teams team

# https://learn.microsoft.com/en-us/microsoft-365/solutions/per-group-guest-access?view=o365-worldwide

(Invoke-GraphRequest -Uri https://graph.microsoft.com/beta/Groups/$groupId/settings -Method GET) | ConvertTo-Json | ConvertFrom-Json | fl Value
(Get-MgBetaGroupSetting -GroupId $groupId | Where-Object { $_.DisplayName -eq "Group.Unified.Guest"}).Values
# name = "AllowToAddGuests" value = "false"
