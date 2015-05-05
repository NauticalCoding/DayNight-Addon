-- Light
util.AddNetworkString("LIGHTMAP_REFRESH");

local LIGHT = {
	
	key = "light",
	lightEntity = nil,
	fakeLighting = {},
}

LIGHT.fakeLighting["a"] = "b"; // a is retarded dark when using engine.LightStyle
LIGHT.fakeLighting["b"] = "c"; // looks better during mornings..

function LIGHT:Init() // int

	local lightList = ents.FindByClass( "light_environment" );
	
	if (#lightList > 0) then
	
		self.lightEntity = lightList[1];
		return 0; // yay, we found the light environment!
	end
	
	return 1;
end

// Accessors


// Modifiers

function LIGHT:ChangeLighting(brightness)
	
	if (self.lightEntity != nil) then
		self.lightEntity:Fire( 'FadeToPattern', brightness, 0 );
	else // need some other form of lighting manipulation...
	
		local fakeBrightness = self.fakeLighting[brightness] || brightness;
		
		engine.LightStyle(0,fakeBrightness);
		timer.Simple(.5,function()
			net.Start("LIGHTMAP_REFRESH")
			net.Broadcast();
		end)
	end
end

-- Add to script

AddDayNightObject(LIGHT);