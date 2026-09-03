-- =======================================================================================================

--[[
	|+|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|+|
	|°|                                              |°|
	|°|      Curve Generator for BeamNG Modders      |°|
	|°|               - Version 0.1.0                |°|
	|°|                - by JENZIBOY                 |°|
	|°|                      <3                      |°|
	|°|                                              |°|
	|+|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|+|
]]

-- Core Modules

local engine 		= require("modules.engine")
local turbo 		= require("modules.turbocharger")
local transmission 	= require("modules.transmission")

-- Misc.

local help = require("util.helper")

-- ***********************************************************
-- ------------------------- HELPER --------------------------
-- ***********************************************************

local function print_menu()
	print("-----------------------------------------------------------")
	print("----------- Curve Generator for BeamNG Modding ------------")
	print("-----------------------------------------------------------\n")

	print("[ 1 ] Torque Curve")
	print("[ 2 ] Turbo Boost Curve")
	print("[ 3 ] Gear Ratio Generator")
	print("[ 4 ] Exit")
end

local function boost_cgen()
	print("-----------------------------------------------------------")
	print("------------- Curve Generator for Turbo Boost -------------")
	print("-----------------------------------------------------------\n")

	io.write("Spool Start RPM?: ")
	local spool_start = io.read()

	io.write("Full Boost Turbine RPM?: ")
	local peak_rpm = io.read()

	io.write("Max Turbine RPM?: ")
	local max_rpm = io.read()

	io.write("Target Boost (bar)?: ")
	local target_boost = io.read()

	io.write("Curve Points?: ")
	local points = io.read()

	turbo.generateTurboCurve(
		spool_start,
		peak_rpm,
		max_rpm,
		target_boost,
		points
	)
end

local function torque_cgen()
	print("-----------------------------------------------------------")
	print("------------ Curve Generator for Engine Torque ------------")
	print("-----------------------------------------------------------\n")

	io.write("Target Power?: ")
	local target_power = io.read()

	io.write("Peak RPM?: ")
	local peak_rpm = io.read()

	io.write("Max RPM?: ")
	local max_rpm = io.read()

	io.write("Curve Points?: ")
	local points = io.read()

	engine.generateTorqueCurve(
		target_power,
		peak_rpm,
		max_rpm,
		points
	)
end

local function gear_gen()
	print("-----------------------------------------------------------")
	print("------------------- Gear Ratio Generator ------------------")
	print("-----------------------------------------------------------\n")

	io.write("Target Top Speed?: ")
	local target_top_speed = io.read()

	io.write("Desired First Gear Speed?: ")
	local first_gear_speed = io.read()

	io.write("Limiter RPM?: ")
	local limiter_rpm = io.read()

	io.write("Final Drive?: ")
	local final_drive = io.read()

	io.write("Gears?: ")
	local gear_count = io.read()

	transmission.getGearRatios(
		target_top_speed,
		first_gear_speed,
		limiter_rpm,
		final_drive,
		gear_count
	)
end

-- Torque / Power Curve Generator

-- ******************************************
-- ------------- MAIN FUNCTION -------------- 
-- ******************************************

while true do
	print_menu()

	io.write("Your choice: ")
	local choice = tonumber(io.read())

	if choice == 1 then
		torque_cgen()

	elseif choice == 2 then
		boost_cgen()

	elseif choice == 3 then
		gear_gen()

	elseif choice == 4 then
		break

	else
		print("Invalid choice")
	end

	print()
end

-- =======================================================================================================