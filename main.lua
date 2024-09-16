local json = require "json"

--[[
    Converte o array de transição em uma table de chaves do 
    caractere para ler concatenado com o estado atual
    Ex: to: 1, read "a", viraria a chave "1a"
]]
local function convert_transition_array(machine_table)
    for transition in machine_table["transitions"] do
        for k, v in pairs(transition) do
            local key = v.from .. v.read
            local table = {}
            table.to = v.to
            table.write = v.write
            table.go_right = true
            if v.dir ~= "R" then
                table.go_right = false
            end
            transition[key] = table
            transition[k] = nil
        end
    end
end


local function create_tape(string, list)
    for char in string do
        list = DoubleLinkedList.append_right(list, char)
    end
    return list
end

local function main()
    local machine_file;
    local input_file;
    local machine_str = ""
    local tape_str = ""
    local machine_json = {}
    local tape_list = DoubleLinkedList.new()
    if not arg[2] then
       print("Sem argumentos para executar script")
        return
    end
    machine_file = io.open(arg[1], "r")
    if not machine_file then
        error("Arquivo ".. arg[1] .. " nao encontrado")
        return
    end
    input_file = io.open(arg[2], "r")
    if not input_file then
        machine_file.close(machine_file)
        error("Arquivo " .. arg[2] .. " nao encontrado")
    end
    machine_str = input_file.read(input_file, "a")
    machine_file.close(machine_file)
    machine_table = json.parse(machine_str)
    convert_transition_array(machine_table)

end

main()