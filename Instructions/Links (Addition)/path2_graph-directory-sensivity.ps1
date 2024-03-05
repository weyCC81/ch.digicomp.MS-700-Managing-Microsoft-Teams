# MS-700-lab_M02_ak.md
#### Task 1 – Activate sensitivity labels for Teams


#1. Connect to the **Client 1 VM** with the credentials that have been provided to you.
#2. Open **Windows PowerShell** and run as Administrator.
#3. Connect to your AAD tenant.
#    <mark>Module is depricated after March 2024</mark>
#    Enter the following cmdlet in the PowerShell window and press **Enter**. In the Sign-in window, sign in as the Global admin - MOD Administrator(admin@&lt;YourTenant&gt;.onmicrosoft.com).
#Connect-AzureAD
Connect-MgGraph -ContextScope Process -Scopes "Directory.ReadWrite.All" -NoWelcome

#4. Fetch the current group settings for the Entra ID (Azure AD) organization
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

# -- Check new values
(Get-MgBetaDirectorySetting | Where-Object { $_.DisplayName -eq "Group.Unified"}).Values

#8. Disconnects the current session from an Azure Active Directory tenant and closes the PowerShell window.
#Disconnect-AzureAD
#Disconnect-MgGraph


