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

local heartSym = " "
local catSym = "♥ "
local sparkleSym = " "
local newline = "\n"

local attributes = {
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
    { " Welcome Back ! ", highlightClrs.purple },
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
    { " You are ", highlightClrs.yellow },
    { "loved ", highlightClrs.pink },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.lavender },
    { " You are ", highlightClrs.yellow },
    { "cherished ", highlightClrs.purple },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { heartSym, highlightClrs.lavender },
    { " You are ", highlightClrs.yellow },
    { "deserving ", highlightClrs.blue },
    { heartSym, highlightClrs.lavender },
    { newline, highlightClrs.white },
    { catSym, highlightClrs.pink },
    { " You are ", highlightClrs.yellow },
    { "adorable!!! ", highlightClrs.sapphire },
    { catSym, highlightClrs.pink },
    { newline, highlightClrs.white },
    { newline, highlightClrs.white },
    { sparkleSym, highlightClrs.yellow },
    { " Have an incredible and amazing day :) ", highlightClrs.purple },
    { sparkleSym, highlightClrs.yellow },
}

local ns = vim.api.nvim_create_namespace("sylvee:message")

local buf = vim.api.nvim_create_buf(false, true)

---@type string[][]
local lines = {}
local hls = {}
vim.iter(ipairs(attributes)):each(function(_, pair)
    if pair[1] == newline then
        table.insert(lines, {})
        return
    end
    if not lines[#lines] or type(lines[#lines]) ~= "table" then
        table.insert(lines, {})
    end
    local text, hl = pair[1], pair[2]
    local l = vim.fn.strdisplaywidth(text)
    local line, col =
        #lines - 1, vim.iter(ipairs(lines[#lines])):fold(0, function(acc, _, cur)
            return acc + vim.fn.strdisplaywidth(cur) + 1
        end)
    table.insert(lines[#lines], text)
    table.insert(hls, { line, col, col + l, hl, text })
end)

vim.api.nvim_buf_set_lines(
    buf,
    0,
    -1,
    true,
    vim.iter(ipairs(lines)):fold({}, function(acc, _, l)
        table.insert(acc, table.concat(l))
        return acc
    end)
)
vim.iter(ipairs(hls)):each(function(_, props)
    local line, col_start, col_end, hl = unpack(props)
    vim.api.nvim_buf_set_extmark(buf, ns, line, col_start, { end_col = col_end, hl_group = hl })
end)

local bgwin = vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), false, {
    relative = "editor",
    col = 0,
    row = 0,
    width = vim.o.columns,
    height = vim.o.lines,
    border = "none",
})

local group = vim.api.nvim_create_augroup("sylvee:message", { clear = true })

local textbox = {
    height = #lines,
    width = vim.iter(ipairs(lines)):fold(0, function(ln, _, l)
        local length = vim.fn.strdisplaywidth(table.concat(l))
        if length > ln then
            return length
        end
        return ln
    end),
}

local fgwin = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = (vim.o.lines - textbox.height) / 2,
    col = (vim.o.columns - textbox.width) / 2,
    height = textbox.height,
    width = textbox.width,
    border = "none",
})

local close = function()
    vim.iter(ipairs({ bgwin, fgwin })):each(function(_, w)
        if not vim.api.nvim_win_is_valid(w) then
            return
        end
        vim.api.nvim_win_close(w, true)
    end)
end

vim.api.nvim_create_autocmd("WinLeave", {
    group = group,
    once = true,
    callback = function()
        close()
    end,
})
vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    once = true,
    callback = function(ev)
        if ev.match == fgwin then
            close()
        end
    end,
})

vim.api.nvim_set_hl(0, "Trans", { bg = "NONE" })
vim.api.nvim_set_option_value("winhighlight", "Normal:Trans", { win = fgwin })
vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
vim.api.nvim_set_option_value("number", false, { win = bgwin })
vim.api.nvim_set_option_value("number", false, { win = fgwin })

vim.keymap.set("n", "q", close, { buffer = buf })
