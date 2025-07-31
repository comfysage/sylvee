-- Ending line. DO NOTE MOVE.

-- highlight group color conversions
local highlightClrs = {
    white = "Normal",
    red = "Error",
    green = "String",
    blue = "Function",
    yellow = "Type",
    pink = "Special",
    purple = "Keyword",
    lavender = "CursorLineNr",
    sapphire = "Label",
}

local heartSym = ""
local catSym = "󱩡"
local sparkleSym = ""
local newline = "\n"

local doneTxt = "Done!"
local welcomeTxt = " Welcome back ! "
local youAreTxt = " You are "
local loveTxt = "loved "
local cherishTxt = "cherished "
local deserveTxt = "deserving "
local adorbsTxt = "adorable!!! "
local closingTxt = " Have an incredible and amazing day :) "

local attributes = {
    { doneTxt, highlightClrs.green },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { welcomeTxt, highlightClrs.purple },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { heartSym, highlightClrs.sapphire },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.lavender },
    { youAreTxt, highlightClrs.yellow },
    { loveTxt, highlightClrs.pink },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.lavender },
    { youAreTxt, highlightClrs.yellow },
    { cherishTxt, highlightClrs.purple },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.lavender },
    { youAreTxt, highlightClrs.yellow },
    { deserveTxt, highlightClrs.blue },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { catSym, highlightClrs.pink },
    { youAreTxt, highlightClrs.yellow },
    { adorbsTxt, highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { sparkleSym, highlightClrs.yellow },
    { closingTxt, highlightClrs.purple },
    { sparkleSym, highlightClrs.yellow },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
}

vim.api.nvim_echo(attributes, true, {})
