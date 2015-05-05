-- Sky

if (CLIENT) then return end

local SKY = {
	
	key = "sky",
	skyEntity = nil,
	
	skyColor = DAYNIGHT.SKY.skyColor,
	duskColor = DAYNIGHT.SKY.duskColor,
	horizonColor = DAYNIGHT.SKY.horizonColor,
	morningColor = DAYNIGHT.SKY.morningColor,
	drawStars = DAYNIGHT.SKY.drawStars,
}

function SKY:Init()
	
	local retInt;
	local skyList = ents.FindByClass( "env_skypaint" );
	
	if (#skyList > 0) then
	
		self.skyEntity = skyList[1];
		retInt = 0;
	else
	
		self.skyEntity = ents.Create( "env_skypaint" );
		self.skyEntity:Spawn();
		retInt = 1;
	end
	
	self.skyEntity:SetNetworkKeyValue("topcolor",Format( "%f %f %f", self.skyColor.r / 255, self.skyColor.g / 255, self.skyColor.b / 255 ));
	self.skyEntity:SetNetworkKeyValue("bottomcolor",Format( "%f %f %f", self.horizonColor.r / 255, self.horizonColor.g / 255, self.horizonColor.b / 255 ));
	self.skyEntity:SetNetworkKeyValue("fadebias",Format( "%f", 1));
	self.skyEntity:SetNetworkKeyValue("duskcolor",Format( "%f %f %f", self.duskColor.r / 255, self.duskColor.g / 255, self.duskColor.b / 255 ));
	self.skyEntity:SetNetworkKeyValue("duskscale",Format("%f",1));
	self.skyEntity:SetNetworkKeyValue("duskintensity",Format("%f",1));
	self.skyEntity:SetNetworkKeyValue("hdrscale",Format("%f",1));
	self.skyEntity:SetNetworkKeyValue("drawstars",tostring(self.drawStars));
	self.skyEntity:SetNetworkKeyValue("startexture","skybox/starfield");
	self.skyEntity:SetNetworkKeyValue("starspeed",Format("%f",.01));
	self.skyEntity:SetNetworkKeyValue("starfade",Format("%f",1.5));
	
	return retInt;
end

// Accessors


// Modifiers

function SKY:SetSkyColor(color)

	self.skyEntity:SetNetworkKeyValue("topcolor",Format( "%f %f %f", color.r / 255, color.g / 255, color.b / 255 ));
	self.skyEntity.skyColor = color;
end

function SKY:SetHorizonColor(color)

	self.skyEntity:SetNetworkKeyValue("bottomcolor",Format( "%f %f %f", color.r / 255, color.g / 255, color.b / 255 ));
	self.skyEntity.horizonColor = color;
end

function SKY:SetDuskColor(color)

	self.skyEntity:SetNetworkKeyValue("duskcolor",Format( "%f %f %f", color.r / 255, color.g / 255, color.b / 255 ));
	self.skyEntity.duskColor = color;
end

function SKY:SetMorningColor(color)

	self.skyEntity.morningColor = color;
end

function SKY:SetDrawStarts(bool)

	self.skyEntity:SetNetworkKeyValue("drawstars",tostring(bool));
	self.skyEntity.drawStars = bool;
end

function SKY:SetDuskScale(float)

	self.skyEntity:SetNetworkKeyValue("duskscale",Format("%f",float));
	self.skyEntity:SetNetworkKeyValue("duskintensity",Format("%f",float));
end

-- Add to script

AddDayNightObject(SKY)