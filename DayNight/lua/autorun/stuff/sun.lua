-- Sun

local SUN = {
	
	key = "sun",
	sunEntity = ents.GetAll()[1],
}

function SUN:Init() // int

	local sunList = ents.FindByClass("env_sun");
	
	if (#sunList > 0) then
	
		self.sunEntity = sunList[1];
		return 0; // yay, we found the sun!
	end
	
	// well lets fuckin make one
	/* doesn't work in all maps =[
	self.sunEntity = ents.Create("env_sun");
	self.sunEntity:Spawn();
	*/
	return 1;
end

// Helper

function SUN:IsValid()

	if (self.sunEntity == nil) then 
	
		return false
		
	else
	
		return true
	end
end

// Modifiers

function SUN:SetAngle(ang) // void

	if (!self:IsValid()) then return end
	
	ang.p = math.Round(ang.p); // round dis shit, don't want crashes do we?
	ang.y = math.Round(ang.y + DAYNIGHT.SKY.sunRotation);
	ang.r = math.Round(ang.r);

	self.sunEntity:SetKeyValue("sun_dir",tostring( ang:Forward() )); // set sun position
end

function SUN:SetSize(size)

	if (!self:IsValid()) then return end
	
	size = math.Round(size);
	self.sunEntity:SetKeyValue( "size", size );
end

-- Add to script

AddDayNightObject(SUN);