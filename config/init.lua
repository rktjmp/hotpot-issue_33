local package_path_str = table.concat({
    "/opt/here/share/lua/5.1/?.lua", "/opt/here/share/lua/5.1/?/init.lua",
    "/opt/here/lib/luarocks/rocks-5.1/?.lua",
    "/opt/here/lib/luarocks/rocks-5.1/?/init.lua"
}, ";")

if not string.find(package.path, package_path_str, 1, true) then
    package.path = package.path .. ';' .. package_path_str
end

local install_cpath_pattern = "/opt/here/lib/lua/5.1/?.so"

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
    package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local hotpot_path = vim.fn.stdpath("data") ..
                        "/site/pack/packer/start/hotpot.nvim"
if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
    print("Could not find hotpot.nvim, cloning new copy to", hotpot_path)
    vim.fn.system({
        "git", "clone", "-b", "provides-fennel", "https://github.com/rktjmp/hotpot.nvim", hotpot_path
    })
end

require("hotpot").setup({
    compiler = {
        macros = {env = "_COMPILER", compilerEnv = _G, allowedGlobals = false}
    }
})
require("core")

local function double_quote(str) return string.format([["%s"]], str) end

local function echo(str) vim.cmd(string.format("echom %s", double_quote(str))) end

local function warn(str)
    vim.cmd(string.format([[
    echohl WarningMsg
    echom %s
    echohl None
    ]], double_quote(str)))
end

local exists, _ = pcall(require, "rex_pcre2")
if exists then
    echo("'rex_pcre2' module is available from init.lua")
else
    warn("'rex_pcre2' module is NOT available from init.lua")
end
