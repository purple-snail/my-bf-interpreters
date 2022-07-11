local tape = {}
local print_output = {}
local user_input = {}
local opening_brackets = {}
local closing_brackets = {}
local instructions = io.read()
local code_pointer = 1
local tape_pointer = 1


for _ = 1, 30000 do
    table.insert(tape, #tape + 1, 0)
end


local temp_brackets = {}
for i = 1, #instructions do
    local instruction = string.sub(instructions, i, i)
    if instruction == '[' then
        table.insert(temp_brackets, #temp_brackets + 1, i)
    elseif instruction == ']' then
        table.insert(opening_brackets, #opening_brackets + 1, temp_brackets[#temp_brackets])
        table.insert(closing_brackets, #closing_brackets + 1, i)
        table.remove(temp_brackets, #temp_brackets)
    end
end


function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

while code_pointer <= #instructions do
    local instruction = string.sub(instructions, code_pointer, code_pointer)

    if instruction == '+' then
        if tape[tape_pointer] == 255 then
            tape[tape_pointer] = 0
        else
            tape[tape_pointer] = tape[tape_pointer] + 1
        end
    elseif instruction == '-' then
        if tape[tape_pointer] == 0 then
            tape[tape_pointer] = 255
        else
            tape[tape_pointer] = tape[tape_pointer] - 1
        end
    elseif instruction == '>' then
        if tape_pointer == #tape then
            tape_pointer = 1
        else
            tape_pointer = tape_pointer + 1
        end
    elseif instruction == '<' then
        if tape_pointer == 1 then
            tape_pointer = #tape
        else
            tape_pointer = tape_pointer - 1
        end
    elseif instruction == '.' then
        table.insert(print_output, #print_output + 1, string.char(tape[tape_pointer]))
    elseif instruction == ',' then
        if #user_input == 0 then
            if #print_output ~= 0 then
                for i = 1, #print_output do
                    io.write(print_output[i])
                end
                io.write('\n')
                for i in pairs(print_output) do print_output[i] = nil end
            end

            io.write(': ')
            local input = io.read()

            for i = 1, #input do
                table.insert(user_input, #user_input + 1, string.byte(string.sub(input, i, i)))
            end
        end

        tape[tape_pointer] = user_input[1]
        table.remove(user_input, 1)
    elseif instruction == '[' then
        if tape[tape_pointer] == 0 then
            code_pointer = closing_brackets[table.indexOf(opening_brackets, code_pointer)]
        end
    elseif instruction == ']' then
        if tape[tape_pointer] ~= 0 then
            code_pointer = opening_brackets[table.indexOf(closing_brackets, code_pointer)]
        end
    end

    code_pointer = code_pointer + 1
end

for i = 1, #print_output do
    io.write(print_output[i])
end
