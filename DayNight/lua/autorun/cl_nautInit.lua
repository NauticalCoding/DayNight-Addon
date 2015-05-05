//
/*

	Day/Night cycle
	
	made by Nautical
	
	4/5/2015
*/

if (SERVER) then return end

include("stuff/config.lua")

net.Receive("LIGHTMAP_REFRESH",function()

	render.RedownloadAllLightmaps();
end)

// Post Processing

local function PostProcess()

	if (!DAYNIGHT.LIGHT.postProcessing) then return end;

	local sun = util.GetSunInfo();
	
	if (sun == nil) then return end
	
	local sunpos = LocalPlayer():EyePos() + sun.direction * 4096;
	local scrpos = sunpos:ToScreen()
 
	local dot = (sun.direction:Dot( LocalPlayer():GetAimVector() ) - 0.8) * 5;
	if (dot <= 0) then return end
 
	DrawSunbeams( 0, // darken
				dot * sun.obstruction,
				0.045, // size
				scrpos.x / ScrW(), 
				scrpos.y / ScrH()
				);
				
	DrawBloom( 0, 0.45, 3, 3, 2, 1, 0.001, 0.001, 0.001 );
end

hook.Add("RenderScreenspaceEffects","Naut_PostProcess",PostProcess);