//
/*

	Day/Night cycle
	
	made by Nautical
	
	4/5/2015
*/

if (CLIENT) then return end

-- Setup
AddCSLuaFile("cl_nautInit.lua");
AddCSLuaFile("stuff/config.lua")
include("stuff/config.lua");

RunConsoleCommand( "sv_skyname", "painted" );

-- Get Objects
local objects = {}

function AddDayNightObject(obj)
	
	objects[obj.key] = obj;
	
	print("Added object: " .. obj.key)
end

include("stuff/sky.lua");
include("stuff/sun.lua");
include("stuff/light.lua");

-- Color table math
local function CTM(color,float) // Color Table Multiply
	
	local newColor = Color(0,0,0);
	newColor.r = color.r * float;
	newColor.g = color.g * float;
	newColor.b = color.b * float;

	return newColor
end

-- Change the sun position / sky color according to time
local timeRef = CurTime(); // a reference for when the script starts

local cycleState = "morning";
local timeElapsed = 0;

local timeCycleStateRef = CurTime() // a reference for when a cycle state starts (morning,day,night,dusk,etc)
local timeCycleStateElapsed = 0;

local function Think()

	timeElapsed = ( CurTime() - timeRef ) / 60; // minutes elapsed
	timeCycleStateElapsed = ( CurTime() - timeCycleStateRef ) / 60;
	
	// Decide the cycle state
	if (timeElapsed > DAYNIGHT.SKY.morningLength && cycleState == "morning") then
	
		cycleState = "day";
		timeCycleStateRef = CurTime();
		objects.light:ChangeLighting("m");
	elseif(timeElapsed > DAYNIGHT.SKY.morningLength + DAYNIGHT.SKY.dayLength && cycleState == "day") then
	
		cycleState = "dusk";
		timeCycleStateRef = CurTime();
		objects.light:ChangeLighting("e");
	elseif(timeElapsed > DAYNIGHT.SKY.morningLength + DAYNIGHT.SKY.dayLength + DAYNIGHT.SKY.duskLength && cycleState == "dusk") then
	
		cycleState = "night";
		timeCycleStateRef = CurTime();
		objects.light:ChangeLighting("a");
	elseif(timeElapsed > DAYNIGHT.SKY.morningLength + DAYNIGHT.SKY.dayLength + DAYNIGHT.SKY.duskLength + DAYNIGHT.SKY.nightLength && cycleState == "night") then
		// Reset
		cycleState = "morning";
		timeRef = CurTime();
		timeCycleStateRef = CurTime();
		
		objects.light:ChangeLighting("b");
	end
	
	// Move the sun + change sky
	
	local frac;
	local skyCol;
	local horCol;
	local duskCol;
	local duskMult = 0; // default to zero
	local sunAng;
	
	if (cycleState == "morning") then
		
		frac = (timeCycleStateElapsed /  DAYNIGHT.SKY.morningLength);
		
		duskMult = math.sin(frac * 3.14); // smooth dusk transition...
		
		skyCol = CTM(objects.sky.skyColor,frac);
		horCol = CTM(objects.sky.horizonColor,frac);
		duskCol = objects.sky.morningColor;
		sunAng = Angle(30 + frac * -60,0,0);
		
	elseif(cycleState == "day") then

		frac = (timeCycleStateElapsed /  DAYNIGHT.SKY.dayLength);
		skyCol = objects.sky.skyColor;
		horCol = objects.sky.horizonColor;
		duskCol = Color(0,0,0);
		sunAng = Angle(-30 + frac * -120,0,0)
		
	elseif(cycleState == "dusk") then
	
		frac = (timeCycleStateElapsed / DAYNIGHT.SKY.duskLength);
		
		duskMult = math.sin(frac * 3.14);
		
		skyCol = CTM(objects.sky.skyColor,1 - frac);
		horCol = CTM(objects.sky.horizonColor,1 - frac);
		duskCol = objects.sky.duskColor;
		sunAng = Angle(-150 + frac * -90,0,0);
		
	elseif(cycleState == "night") then
	
		sunAng = Angle(90,0,0);
		horCol = Color(0,0,0);
		skyCol = Color(0,0,0);
		duskCol = Color(0,0,0);
	end
	
	if (objects.sun:IsValid()) then

		objects.sky:SetDuskScale(duskMult);
	else
		
		objects.sky:SetDuskColor(Color(0,0,0));
		objects.sky:SetDuskScale(0);
		objects.sun:SetSize(0);
		objects.sun:SetAngle(Angle(90,0,0));
	end
	
	objects.sun:SetAngle(sunAng);
	objects.sky:SetSkyColor(skyCol);
	objects.sky:SetHorizonColor(horCol);
	objects.sky:SetDuskColor(duskCol);
end

-- Start

timer.Simple(10,function()
	
	for k,v in pairs(objects) do 
	
		print( k .. " init returned: " .. v:Init());
	end
	
	objects.light:ChangeLighting("b");
	
	timeRef = CurTime();
	timeCycleStateRef = timeRef;

	hook.Add("Think","DayNightThink",Think);
end)



