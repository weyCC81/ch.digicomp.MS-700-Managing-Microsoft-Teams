#Install-Module MicrosoftTeams -Scope AllUsers
Install-Module Microsoft.Graph -Scope AllUsers


#Connect-MgGraph -Scopes "Team.Create"
Connect-MgGraph -Scopes "Group.ReadWrite.All, Team.ReadBasic.All"


(Find-MgGraphCommand -Command New-MgTeam).Permissions
#Name                         IsAdmin Description  
# Directory.ReadWrite.All False   Read and write directory data
# Group.ReadWrite.All     False   Read and write all groups
# Team.Create             False   Create teams
# Teamwork.Migrate.All    False   Create chat and channel messages with anyone's identity and with… 

(Find-MgGraphCommand -Command Get-MgTeam).Permissions
#Name                         IsAdmin Description                                           
#Directory.Read.All           False   Read directory data                
#Directory.ReadWrite.All      False   Read and write directory data      
#Group.Read.All               False   Read all groups                    
#Group.ReadWrite.All          False   Read and write all groups          
#Team.ReadBasic.All           False   Get a list of all teams            
#TeamSettings.Read.All        False   Read all teams' settings           
#TeamSettings.Read.Group      False   Consent name unavailable           
#TeamSettings.ReadWrite.All   False   Read and change all teams' settings
#TeamSettings.ReadWrite.Group False   Consent name unavailable           
#Team.ReadBasic.All           False   Get a list of all teams            
#TeamSettings.Read.All        False   Read all teams' settings           
#TeamSettings.ReadWrite.All   False   Read and change all teams' settings

# Invoke-RestMethod
# No Token (Session)

$output = Invoke-MgGraphRequest -Method GET https://graph.microsoft.com/v1.0/teams; $output
#Invoke-MgGraphRequest -Method POST -Uri $uri -Body
# Graph Token (Session from Connect)
$output.value

# > "error":{"code":"Forbidden","message":"Missing scope permissions on the request. API requires one of 'Team.ReadBasic.All, TeamSettings.Read.All, TeamSettings.ReadWrite.All'. Scopes on the request 'Group.ReadWrite.All, openid, profile, Team.Create, email'","innerError":{"date":"2024-03-03T15:12:36","request-id":"3bad8454-b906-473b-8c40-a567712509d4","client-request-id":"1fb9b0de-91a0-44f7-9338-181a55e7ca53"}}}

# --- Part 2

$uri = @'
https://graph.microsoft.com/v1.0/teams
'@
#$uri = "https://graph.microsoft.com/beta/teams"

# HERE-STRINGS  @'   '@
# The quotation rules for here-strings are slightly different.
# A here-string is a single-quoted or double-quoted string in which quotation marks are interpreted literally. A here-string can span multiple lines. All the lines in a here-string are interpreted as strings even though they are not enclosed in quotation marks.
# Like regular strings, variables are replaced by their values in double-quoted here-strings. In single-quoted here-strings, variables are not replaced by their values.

$body = @'
{
"template@odata.bind":"https://graph.microsoft.com/v1.0/teamsTemplates('standard')",
"displayName": "Early Adopters (PowerShell)",
"description": "The Early Adopters Workspace.",
"visibility": "Public" 
}
'@

Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body


