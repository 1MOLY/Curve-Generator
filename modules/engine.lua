local M = {}

local help = require("util.helper")

-- ***********************************************************
-- ------------------------- PRIVATE -------------------------
-- ***********************************************************

local LOW_RPM_WIDTH = 0.45
local HIGH_RPM_WIDTH = 0.14

-- ***********************************************************
-- ------------------------- PUBLIC -------------------------- 
-- ***********************************************************

--- Generates a torque curve
function M.generateTorqueCurve(target_power, peak_rpm, max_rpm, points)
	local tp = tonumber(target_power)
	local pr = tonumber(peak_rpm)
	local mr = tonumber(max_rpm)
	local p  = tonumber(points)

	local shouldGenerate = tp ~= nil 
		and pr ~= nil
		and mr ~= nil
		and p ~= nil

	if not shouldGenerate then
		return
	end

	local start_rpm = 350
	local target_torque = help.convert_PsToTrq(tp, pr)

	local curve = {}

	for i = 0, p - 1 do
		local t = i / (p - 1)

		local rpm = start_rpm + (mr - start_rpm) * t
		local dist = (rpm - pr) / mr

		local width = rpm < pr
			and LOW_RPM_WIDTH
			or HIGH_RPM_WIDTH

		local torque = math.exp(
			-((dist * dist)) / width
		)

		table.insert(curve, {
			rpm = rpm,
			torque = torque
		})
	end

	local actual_peak_power = 0

	for _, point in ipairs(curve) do
		local power = help.convert_TrqToPs(point.torque, point.rpm)

		if power > actual_peak_power then
			actual_peak_power = power
		end
	end

	local scale = tp / actual_peak_power

	for _, point in ipairs(curve) do
		local torque = point.torque * scale

		print(string.format("[%d, %d],", point.rpm, torque))
	end
end

return M