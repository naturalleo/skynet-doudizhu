local skynet = require("skynet")
require "skynet.manager"

local CMD = {}
local login = {}
local roledb = {
	["123456"] = "linhui",
	["10010"] = "3331723",
	["10086"] = "crazy",
	["misswu"] = "misswu",
	["jean"] = "jean",
	["dabiaoge"] = "dabiaoge",
}

function CMD.checkRole(id, passwork)
	if login[id] then 
		return 10
	end
	local psd = roledb[id]
	if not psd then 
		return 1 -- 无角色
	elseif psd ~= passwork then 
		return 2 -- 密码错误
	end
	login[id] = true
	print("+++++++++++登录成功：", id)
	return 0
end

-- 下线
function CMD.unLine(id)
	if login[id] then 
		print("+++++++++++下线：", id)
		login[id] = nil
	end
end

skynet.start(function()
	skynet.dispatch("lua", function(_, _, cmd, ...)
		local f = CMD[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			error(string.format("Unknown CMD %s", tostring(cmd)))
		end
	end)

	-- skynet.register "ROLEDB"
end)