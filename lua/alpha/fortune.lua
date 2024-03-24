-- fortune printing (from vim-startify)

-- To add this to the footer, simply add the following lines to the config:
-- use {
--     'goolord/alpha-nvim',
--     config = function ()
--         require'alpha.themes.dashboard'.section.footer.val = require'alpha.fortune'()
--         require'alpha'.setup(require'alpha.themes.dashboard'.opts)
--     end
-- }

local format_line = function(line, max_width)
    -- inserts linebreaks into line

    local formatted_line = "\n"
    if line == '' then
        formatted_line = formatted_line .. " "
        return formatted_line
    end

    -- split line by spaces into list of words
    words = {}
    target = "%S+"
    for word in line:gmatch(target) do
        table.insert(words, word)
    end

    bufstart = ""
    buffer = bufstart
    for i, word in ipairs(words) do
        if ((#buffer + #word + 1) < max_width) then
            buffer = buffer .. word .. " "
            if (i == #words) then
                formatted_line = formatted_line .. buffer:sub(1,-2) .. "\n"
                -- table.insert(formatted_lines, buffer:sub(1,-2))
            end
        else
            formatted_line = formatted_line .. buffer:sub(1,-2) .. "\n"
            -- table.insert(formatted_lines, buffer:sub(1,-2))
            buffer = bufstart .. word .. " "
        end
    end
    -- right-justify text if the line begins with -
    if line:sub(1,1) == '-' then
        local space = "\n" .. string.rep(" ", max_width - #formatted_line - 2)
        formatted_line = space .. formatted_line:sub(2,-1)
    end
    return formatted_line
end

local format_fortune = function(fortune, max_width)
    -- Converts list of strings to one formatted string (with linebreaks)
    formatted_fortune = " \n "  -- adds spacing between alpha-menu and footer
    for _, line in ipairs(fortune) do
        local formatted_line = format_line(line, max_width)
        formatted_fortune = formatted_fortune .. formatted_line
    end
    return formatted_fortune
end

local get_fortune = function(fortune_list)
    -- selects an entry from fortune_list randomly
    math.randomseed(os.time())
    local ind = math.random(1, #fortune_list)
    return fortune_list[ind]
end



local main = function()
    local max_width = 54
    local fortune_list = require("alpha.quotes")
    local fortune = get_fortune(fortune_list)
    local formatted_fortune = format_fortune(fortune, max_width)
    return formatted_fortune
end

return main
