

# --- Implement lifecycle management and governance for Microsoft Teams
# -- Exchange
#Get-Module -ListAvailable
Install-Module ExchangeOnlineManagement -Scope AllUsers

Connect-ExchangeOnline

# Upgrade-DistributionGroup -DlIdentities marketing-dl@contoso.com, finance-dl@contoso.com
# Depricated?
# Get-EligibleDistributionGroupForMigration 

New-UnifiedGroup -DisplayName "Sales Department" -Alias Salesdepartment
Set-UnifiedGroup -DisplayName "Sales Department" -RequireSenderAuthenticationEnabled $false

# -- Teams
# Grant-CsUserPolicyPackage
