#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "boomix"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
//#include <sdkhooks>

#pragma newdecls required

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
	
	//If username is too short
	if(strlen(username) < 3)
		ChangeUsername(client);
	
	
	//If username does not contain normal symbols
	int count = 0;
	for (int i = 0; i < strlen(username); i++)
	{
		//if(username[i])
	}
	
}

void ChangeUsername(int client)
{
	
}