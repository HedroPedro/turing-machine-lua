local json = require "json"
local data_structures = require "data_structures"

local function main()
    local machine_file;
    local input_file;
    local machine_str = ""
    local machine_json = {}
    local linked_list = DoubleLinkedList.new()
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
    machine_json = json.parse(machine_str)
    print(machine_str)
    machine_file.close(machine_file)
end

main()