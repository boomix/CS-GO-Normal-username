#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "boomix"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>

#pragma newdecls required

//Allowed symbols
char g_sAllowedSymbols[150] = "aābcčdeēfgģhiījkķlļmnņoprsštuūvzž0123456789wqyx ";

//Usernames to replace with
char g_sNewUsernames[][] = {
	"vāvare", "zebiekste", "frodze", "mušmire", "līdaka", "varde", "zivs"
};

public Plugin myinfo = 
{
	name = "Normal username",
	author = PLUGIN_AUTHOR,
	description = "Check if is username with 3 symbols and is readable",
	version = PLUGIN_VERSION,
	url = "https://identy.lv"
};

public void OnPluginStart()
{
	HookEvent("player_changename", Event_PlayerNameChange);
}

public Action Event_PlayerNameChange(Handle event, const char[] name, bool dontBroadcast)
{
	//Right after name change, check if it is valid
	CreateTimer(0.1, CheckUsername, GetEventInt(event, "userid"));
}

public Action CheckUsername(Handle tmr, any userID)
{
	int client = GetClientOfUserId(userID);
	if(client > 0)
		OnClientAuthorized(client, "");
}

public void OnClientAuthorized(int client, const char[] auth)
{
	
	//Get client username
	char username[120];
	GetClientName(client, username, sizeof(username));
	
	//If username is too short, then change it
	if(strlen(username) < 3) {
		ChangeUsername(client);
		return;
	}
	
	//Convert string to lowercase and continue with checks
	for (int i = 0; i < strlen(username); i++) {
		if (IsCharAlpha(username[i])) {
			username[i] = CharToLower(username[i]);
		}
	}
	
	//Check if there are 3 symbols in row from allowed symbols
	int count = 0;
	bool bValidUsername = false;
	for (int i = strlen(username); i >= 0; i--) {
		if(StrContains(g_sAllowedSymbols, username[i]) != -1) {
			if(count++ >= 2) bValidUsername = true;
		} else {
			count = 0;
		}
		username[i] = 0;
	}

	
	if(!bValidUsername)
		ChangeUsername(client);
	
}

void ChangeUsername(int client)
{
	int random = GetRandomInt(0, sizeof(g_sNewUsernames) - 1);
	char username[120];
	Format(username, sizeof(username), "Anonīmā %s", g_sNewUsernames[random]);
	SetClientName(client, username);
}