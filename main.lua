local json = require "json"
local data_structures = require "data_structures"
--[[
    Converte o array de transição em uma table de chaves do 
    caractere para ler concatenado com o estado atual
    Ex: to: 1, read "a", vira a chave "1a"
]]

Set = data_structures.Set
DoubleLinkedList = data_structures.DoubleLinkedList

local function convert_transition_and_finals(machine_table)
    local new_transitions = {}
    machine_table["final"] = Set.new(machine_table["final"]) 
    for i, value in pairs(machine_table["transitions"]) do
        local new_index = value["from"] .. value["read"]
        local go_right = true
        if value["dir"] == "L" then
            go_right = false
        end
        new_transitions[new_index] = {to = value["to"], write = value["write"], dir = go_right}
    end
    machine_table["transitions"] = new_transitions
end

local function create_tape(str)
    local tape = DoubleLinkedList.new()
    for i = 1, string.len(str), 1 do
        tape = DoubleLinkedList.append_right(tape, string.sub(str, i, i))
    end
    return tape
end

local function compute_turing_machine(machine, tape)
    local current = machine.initial
    local transitions = machine.transitions
    while true do
        local transition = transitions[current .. tape.info]
        if not transition then
            return false
        end
        current = transition.to
        tape.info = transition.write
        if transition.dir then
            if not tape.next then
                tape = DoubleLinkedList.append_right(tape, machine.white)
            end
            tape = tape.next
        else
            if not tape.before then
                tape = DoubleLinkedList.append_left(tape, machine.white)
            end
            tape = tape.before
        end
        if Set.contains_any(Set.new({current}), machine.final) then
            return true
        end
    end
end

local function main()
    local machine_file;
    local machine_str = ""
    local machine_table = {}
    local input_file;
    local input_str = ""
    local tape = nil
    if not arg[2] then
       error("Sem argumentos para executar script")
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
    local output_file = io.open("saida.out", "w");
    if not output_file then
        machine_file:close()
        input_file:close()
        error("Incapaz de abrir/criar arquivo de saida")
    end
    machine_str = machine_file:read("a")
    machine_file:close()
    machine_table = json.parse(machine_str)
    convert_transition_and_finals(machine_table)
    while true do
        input_str = input_file:read()
        if input_str == "" or not input_str then
            break
        end
        tape = create_tape(input_str)
        if compute_turing_machine(machine_table, tape) then
            print(1)
        else
            print(0)
        end
        output_file:write(DoubleLinkedList.convert_values_to_string(tape) .. "\n")
    end
    output_file:close()
end

main()