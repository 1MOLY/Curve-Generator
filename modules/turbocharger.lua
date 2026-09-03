local M = {}

local help = require("util.helper")

-- ***********************************************************
-- ------------------------- PRIVATE -------------------------
-- ***********************************************************



-- ***********************************************************
-- ------------------------- PUBLIC -------------------------- 
-- ***********************************************************

--- Generates a turbo boost curve
function M.generateTurboCurve(spool_start, max_boost_rpm, max_turbine_rpm, target_boost, points)
    local ss  = tonumber(spool_start)
    local mbr = tonumber(max_boost_rpm)
    local mtr = tonumber(max_turbine_rpm)
    local tb  = tonumber(target_boost)
    local p   = tonumber(points)

    local shouldGenerate =
        ss  ~= nil and
        mbr ~= nil and
        mtr ~= nil and
        tb  ~= nil and
        p   ~= nil

    if not shouldGenerate or p < 2 then
        return
    end

    local boost_psi = help.convert_BarToPsi(tb)

    for i = 0, p - 1 do
        local t = i / (p - 1)
        local turbine_rpm = mtr * t

        local pressure

        if turbine_rpm < ss then
            pressure = -2.0

        elseif turbine_rpm < mbr then
            local spool_t = (turbine_rpm - ss) / (mbr - ss)
		    pressure = -2.0 + (boost_psi + 2.0) * help.smoothstep(spool_t)

        else
            pressure = boost_psi

        end

        print(string.format(
            "[%d, %.1f],",
            turbine_rpm,
            pressure
        ))
    end
end

return M