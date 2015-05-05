//
/*

	Day/Night cycle
	
	made by Nautical
	
	4/5/2015
*/

print("Including Day/Night config!")

DAYNIGHT = {}

if (SERVER) then
	// Sky configuration

	DAYNIGHT.SKY = {

		sunSize 		= 0, 						-- How bright do you want your sun to be (0 -> 10)
		sunColor 		= Color(255,255,255),		-- What color do you want your sun to be? Look online for rgb codes
		drawStars 		= true, 					-- Do you want to see stars during night time? true means yes, false means no
		skyColor 		= Color(51,127.5,255),		-- What color do you want your sky to be? Look online for rgb codes
		horizonColor 	= Color(130,200,200), 		-- What color do you want your horizon to be? Look online for rgb codes
		duskColor 		= Color(255,153,0), 		-- What color do you want your dusk to be? Look online for rgb codes
		morningColor 	= Color(230,170,130),		-- What color do you want your morning to be? Look online for rgb codes
		
		dayLength 		= 8,						-- How long do you want your day to last? (minutes)
		nightLength 	= 8,						-- How long do you want your night to last? (minutes)
		morningLength 	= 4, 						-- How long do you want your morning to last? (minutes)
		duskLength 		= 4,						-- How long do you want your dusk to last? 	 (minutes)
		
		sunRotation     = 0, 						-- Yaw rotation of the sun, 0 is default (degrees)
	}
else

	// Lighting configuration

	DAYNIGHT.LIGHT = { 

		postProcessing = false, 				   		-- Should the client render sun beams and bloom?
	}
end