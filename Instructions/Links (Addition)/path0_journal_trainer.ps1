# Tag 1
Get-Module -Name MicrosoftTeams -ListAvailable #  6.5.0
Get-Module -Name Microsoft.Graph -ListAvailable # 2.23.0

Install-Module -Name MicrosoftTeams
Install-Module -Name Microsoft.Graph
#Install-Module -Name Microsoft.Graph.Beta


Connect-MicrosoftTeams #-NoWelcome
Connect-MgGraph -NoWelcome
Connect-MgGraph -Scopes "Team.ReadBasic.All, Group.ReadWrite.All" -NoWelcome 



Get-Help New-Team
#(Get-Module -Name MicrosoftTeams).ExportedCommands | Out-GridView
#Get-Command -Module MicrosoftTeams
Get-Team

Get-Help Get-MgTeam*
Get-MgTeam

#Find-MgGraphCommand -Command Get-MgGroup
#Find-MgGraphCommand -Command Update-MgGroup

Get-MgGroup
##Update-MgGroup -GroupId TestDist@WWLx781186.onmicrosoft.com
#Update-MgGroup -DlIdentities TestDist@WWLx781186.onmicrosoft.com # A parameter cannot be found
#Update-MgGroup -GroupId 72d776eb-52bd-4db7-bf99-8d13cf846a47 # No Upgrade possible

# https://mc.merill.net/message/MC870997
# https://learn.microsoft.com/en-us/microsoftteams/trusted-organizations-external-meetings-chat?tabs=organization-settings
Get-CsTenantFederationConfiguration
# ExternalAccessWithTrialTenants              : Blocked
Set-CsTenantFederationConfiguration -ExternalAccessWithTrialTenants "Allowed"


#Disconnect-MicrosoftTeams
#Disconnect-MgGraph


# --- Tag 2

##Install-Module Microsoft.Graph -Scope CurrentUser
#Install-Module Microsoft.Graph.Beta -Scope CurrentUser
Install-Module -Name Microsoft.Graph.Beta -RequiredVersion 2.23.0 -Scope CurrentUser


#Import-Module -Name Microsoft.Graph.Beta -RequiredVersion 2.23.0
Import-Module -Name Microsoft.Graph.Beta.Identity.DirectoryManagement -RequiredVersion 2.23.0

Get-Module -Name Microsoft.Graph.Beta -ListAvailable # 2.24.0 = Error with Get-MgBetaDirectorySettingTemplate' and 'Get-MgBetaDirectorySetting'
Get-Module -Name Microsoft.Graph.*


#Disconnect-MgGraph
Connect-MgGraph -Scopes "Directory.ReadWrite.All" -NoWelcome


$Template = Get-MgBetaDirectorySettingTemplate | Where-Object {$_.DisplayName -eq "Group.Unified"}
if(!($Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"})) {

    $params = @{
        templateId = "$($Template.Id)"
        values = @(
         )
    }
    New-MgBetaDirectorySetting -BodyParameter $params
    $Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}
}


$Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}

$grpUnifiedSetting = Get-MgBetaDirectorySetting -Search DisplayName:"Group.Unified"
# Get-MgBetaDirectorySetting : One or more errors occurred.

$params = @{
    Values = @(
        @{
            Name = "EnableMIPLabels"
            Value = "True"
        }
    )
}

Update-MgBetaDirectorySetting -DirectorySettingId $grpUnifiedSetting.Id -BodyParameter $params

$Setting = Get-MgBetaDirectorySetting -DirectorySettingId $grpUnifiedSetting.Id
$Setting.Values

# -- Tag 3

# Set-MgGroup -Id $groupId -GroupTypes $groupTypes.ToArray() -MembershipRuleProcessingState "On" -MembershipRule $dynamicMembershipRule
Get-MgGroup -GroupId 8d96b825-ec65-45bf-b782-7c71dd40c2ba | fl *, GroupTypes

#GroupTypes                    : {DynamicMembership, Unified}
#MembershipRule                : (user.department -eq "Sales")
#MembershipRuleProcessingState : On

# -- Tag 4


Connect-MicrosoftTeams

#Get-CsOnlineTelephoneNumber | ft Id,ActivationState
Get-CsPhoneNumberAssignment | ft TelephoneNumber, ActivationState

#Get-CsOnlineLisLocation -ValidationStatus Validated
Get-CsOnlineLisLocation | ft Description, Company*, Street*, ValidationStatus

# Grant-CsTenantDialPlan
# Get-CsDialPlan | Out-GridView
Get-CsDialPlan -Identity "Tag:US"


# Set-CsPhoneNumberAssignment -Identity "<User name>" -EnterpriseVoiceEnabled $true
Get-CsPhoneNumberAssignment | ft TelephoneNumber, ActivationState, NumberType, *Voice*, *Enterprise*

# Grant-CsOnlineVoiceRoutingPolicy
Get-CsOnlineVoiceRoutingPolicy | ft

# Grant-CsTeamsCallingPolicy
# Get-CsTeamsCallingPolicy | Out-GirdView
Get-CsTeamsCallingPolicy | ft
