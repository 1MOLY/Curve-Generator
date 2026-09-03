local M = {}

-- ***********************************************************
-- ------------------------- PRIVATE -------------------------
-- ***********************************************************

-- ***********************************************************
-- ------------------------- PUBLIC -------------------------- 
-- ***********************************************************

M.CONVERSION_CONST = 7023.5

function M.smoothstep(t)
	return (t * t * (3 - 2 * t)) or 0
end

function M.convert_PsToTrq(power, rpm)
	return ((power * M.CONVERSION_CONST) / rpm) or 0
end

function M.convert_TrqToPs(torque, rpm)
	return ((torque * rpm) / M.CONVERSION_CONST) or 0
end

function M.convert_BarToPsi(bar)
	return (bar * 14.503773773) or 0
end

function M.convert_PsiToBar(psi)
	return (psi * 0.0689475729) or 0
end

return M