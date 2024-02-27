
# ---- Preparation
https://learn.microsoft.com/en-us/entra/identity/users/groups-settings-cmdlets

# Install-Module -Name MicrosoftTeams -Scope AllUsers


# MS-700-lab_M01_ak.md
#### Task 2 - Configure a group creation policy

# 1. Open **Windows PowerShell** and run as Administrator.
# 2. Install **Azure AD Preview module**
#    <mark>Module is depricated after March 2024</mark>
#   In the PowerShell window, enter the following cmdlet and press **Enter**. Enter **Y** and press **Enter** to confirm the installation of an untrusted repository.

##Install-Module -Name AzureADPreview
#Install-Module Microsoft.Graph -Scope AllUsers
Install-Module Microsoft.Graph.Beta -Scope AllUsers

#3. Connect to your AAD tenant.
#    Enter the following cmdlet in the PowerShell window and press **Enter**. In the Sign-in window, sign in as the Global admin - MOD Administrator(admin@&lt;YourTenant&gt;.onmicrosoft.com).
#Connect-AzureAD
Connect-MgGraph -ContextScope Process -Scopes "Directory.ReadWrite.All" -NoWelcome
# Directory.Read.All, Directory.ReadWrite.All
#Group.Read.All , Group.ReadWrite.All 

# 4. Load the Azure AD unified group template, by using the following cmdlet:
#$Template = Get-AzureADDirectorySettingTemplate | Where-Object {$_.DisplayName -eq "Group.Unified"}
    #(Find-MgGraphCommand -Command Get-MgBetaDirectorySettingTemplate).Permissions
$Template = Get-MgBetaDirectorySettingTemplate | Where-Object {$_.DisplayName -eq "Group.Unified"}
    #$Template | fl *
    #$TemplateId = (Get-MgBetaDirectorySettingTemplate | where { $_.DisplayName -eq "Group.Unified" }).Id
    #$Template = Get-MgBetaDirectorySettingTemplate | where -Property Id -Value $TemplateId -EQ

# 5. Check if an Azure AD setting is already existing and load it, if yes. If not, create a blank Azure AD setting object. Run the following cmdlet to populate the "$Setting" variable:
#if(!($Setting = Get-AzureADDirectorySetting | Where-Object {$_.TemplateId -eq $Template.Id})) {$Setting = $Template.CreateDirectorySetting()}
    #(Find-MgGraphCommand -Command Get-MgBetaDirectorySetting).Permissions
    (Find-MgGraphCommand -Command New-MgBetaDirectorySetting).Permissions
#[Boolean](Get-MgBetaDirectorySetting) # False
#Get-MgBetaDirectorySetting -All | fl *

if(!($Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"})) {

    $params = @{
        templateId = "$($Template.Id)"
        values = @(
           #@{
           #   name = "UsageGuidelinesUrl"
           #   value = "https://guideline.example.com"
           #}
           #@{
           #   name = "EnableMIPLabels"
           #   value = "True"
           #}
        )
    }
    New-MgBetaDirectorySetting -BodyParameter $params
    $Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}
}

# 6. Run the following cmdlet to modify the group creation setting for your tenant with the "EnableGroupCreation" attribute:
#$Setting["EnableGroupCreation"] = "False"

#7. Run the following cmdlet to add the just created security group **GroupCreators** as a permitted group to create groups, by their ObjectID:
#$Setting["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString "GroupCreators").objectid
# Get-MgBetaGroup -Filter "DisplayName eq 'M365-Directory-TeamsGroupCreation'" | fl *
# M365-Directory-TeamsGroupCreation
# M365-Directory-SecurityGroupCreation
$groupId = (Get-MgBetaGroup -Filter "DisplayName eq 'M365-Directory-TeamsGroupCreation'").Id

$params = @{
    Values = @(
       @{
          Name = "EnableGroupCreation"
          Value = "False"
       }
       @{
          name = "GroupCreationAllowedGroupId"
          value = "$($groupId)"
        }
    )
 }

#8. Review the changes you have just configured with the following command:
#$Setting.Values
$params.Values

#9. Save the changes and apply the setting:
#New-AzureADDirectorySetting -DirectorySetting $Setting
#    **Note:** Since this is a new tenant, there’s no directory settings object in the tenant yet. You need to use ```New-AzureADDirectorySetting``` to create a directory settings object for the first time.
Update-MgBetaDirectorySetting -DirectorySettingId $Setting.Id -BodyParameter $params
(Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}).Values

#Disconnect-MgGraph

# MS-700-lab_M02_ak.md
#### Task 1 – Activate sensitivity labels for Teams


#1. Connect to the **Client 1 VM** with the credentials that have been provided to you.
#2. Open **Windows PowerShell** and run as Administrator.
#3. Connect to your AAD tenant.
#    <mark>Module is depricated after March 2024</mark>
#    Enter the following cmdlet in the PowerShell window and press **Enter**. In the Sign-in window, sign in as the Global admin - MOD Administrator(admin@&lt;YourTenant&gt;.onmicrosoft.com).
#Connect-AzureAD
Connect-MgGraph -ContextScope Process -Scopes "Directory.ReadWrite.All" -NoWelcome

#4. Fetch the current group settings for the Azure AD organization
#$Setting = Get-AzureADDirectorySetting -Id (Get-AzureADDirectorySetting | Where-Object -Property DisplayName -Value "Group.Unified" -EQ).id
$Setting = Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}
if(![Boolean](Get-MgBetaDirectorySetting)){Write-Warning "Create DirectorySetting from Template first"}


#5. Enable the Microsoft Identity Protection (MIP) support in your configuration:
#$Setting["EnableMIPLabels"] = "True"

$params = @{
    Values = @(
       @{
          Name = "EnableMIPLabels"
          Value = "True"
       }
    )
 }

#6. To verify the new configuration, run the following cmdlet:
#$Setting.Values
$params.Values

#7. Then save the changes and apply the settings:
#Set-AzureADDirectorySetting -Id $Setting.Id -DirectorySetting $Setting
#	**Note:** If there’s no directory settings object in the tenant yet. You need to use ```New-AzureADDirectorySetting``` to create a directory settings object for the first time.
Update-MgBetaDirectorySetting -DirectorySettingId $Setting.Id -BodyParameter $params
(Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}).Values


#8. Disconnects the current session from an Azure Active Directory tenant and closes the PowerShell window.
#Disconnect-AzureAD
Disconnect-MgGraph

