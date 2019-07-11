#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "boomix"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
//#include <sdkhooks>

#pragma newdecls required

char g_sAllowedSymbols[][] = {
	"a", "ā", "b", "c", "č", "d", "e", "ē", "f", "g", "ģ", "h", "i", "ī", "j", "k", "ķ", "l",
	"ļ", "m", "n", "ņ", "o", "p", "r", "s", "š", "t", "u", "ū", "v", "z", "ž", "0", "1", "2",
	"3", "4", "5", "6", "7", "8", "9", "_", "-", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")"
};

char g_sNewUsernames[][] = {
	"vāvare", "zebiekste", "frodze", "mušmire", "līdaka", "varde", "zivs"
};

public Plugin myinfo = 
{
	name = "Normal username",
	author = PLUGIN_AUTHOR,
	description = "Check if is username with 3 symbols and not with random shit symbols",
	version = PLUGIN_VERSION,
	url = "https://identy.lv"
};

public void OnPluginStart()
{
	
}

public void OnClientAuthorized(int client, const char[] auth)
{
	
	char username[120];
	GetClientName(client, username, sizeof(username));
	
	//If username is too short, change it
	if(strlen(username) < 3)
		ChangeUsername(client);
	
	//Convert string to lowercase
	for (int i = 0; i < strlen(username); i++) {
		if (IsCharAlpha(username[i])) {
			username[i] = CharToLower(username[i]);
		}
	}
	
	//Count how many good symbols username contains
	int count = 0;
	for(int i = 0; i < sizeof(g_sAllowedSymbols[]); i++) {
		if(StrContains(username, g_sAllowedSymbols[i]) != -1) {
			count++;
		}
	}
	
	//If there are not enogh good symbols, change it
	if(count < 3)
		ChangeUsername(client);
	
}

void ChangeUsername(int client)
{
	int random = GetRandomInt(0, sizeof(g_sNewUsernames) - 1);
	char username[120];
	Format(username, sizeof(username), "Anonīmā %s", g_sNewUsernames[random]);
	SetClientName(client, username);
}