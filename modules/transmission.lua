local M = {}

-- ***********************************************************
-- ------------------------- PRIVATE -------------------------
-- ***********************************************************

local commonTireDiameterM = 0.64

local function calcWheelSpeedFromGear(limiter_rpm, gear_ratio, final_drive)
	local wheel_rpm = limiter_rpm / (gear_ratio * final_drive)
	local tireCircumference = math.pi * commonTireDiameterM

	local velocityKMH = wheel_rpm * tireCircumference * 60 / 1000

	return velocityKMH
end

local function calcGearRatioFromSpeed(speed_kmh, limiter_rpm, final_drive)
	local tireCircumference = math.pi * commonTireDiameterM

	return (limiter_rpm * tireCircumference * 60)
		/ (speed_kmh * final_drive * 1000)
end

local function generateRatios(first_gear, last_gear, gear_count, limiter_rpm, final_drive)
	local step = (last_gear / first_gear) ^ (1 / (gear_count - 1))

	for i = 0, gear_count - 1 do
		local ratio = first_gear * (step ^ i)

		print(string.format(
			"%d: %.2f = %.1f km/h", 
			i + 1, ratio, 
			calcWheelSpeedFromGear(limiter_rpm, ratio, final_drive)
		))
	end
end

-- ***********************************************************
-- ------------------------- PUBLIC -------------------------- 
-- ***********************************************************

function M.getGearRatios(target_top_speed, first_gear_speed, limiter_rpm, final_drive, gear_count)
	local top_speed 	= tonumber(target_top_speed)
	local first_speed 	= tonumber(first_gear_speed)
	local rpm        	= tonumber(limiter_rpm)
	local fd         	= tonumber(final_drive)
	local count      	= tonumber(gear_count)

	if not top_speed
		or not first_speed
		or not rpm
		or not fd
		or not count then return
	end

	local tireCircumference = math.pi * commonTireDiameterM

	local firstGear = calcGearRatioFromSpeed(
		first_speed,
		rpm,
		fd
	)

	local lastGear = calcGearRatioFromSpeed(
		top_speed,
		rpm,
		fd
	)

	print("\n-+-+-+- ! ESTIMATED ! -+-+-+-\n")
	generateRatios(firstGear, lastGear, count, rpm, fd)
end

return M