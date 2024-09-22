--[[
    Estrutura de dados parcialmente implementadas pq (eu sou preguiçoso)
    não é necessário implementar tudo...
    Estruturas "implementadas":
    - Conjuntos
    - Lista duplamente encadeadas
    TODO: implementar todas as outras funções caso eu use isso para algo sério
]]--
local data_structures = {}

Set = {}
Set.mt = {}
DoubleLinkedList = {}

--[[
    Para todo mundo que decidir ver o meu código, não precisa usar isso,
    uma table semelhante a {array[], atual}, já era o bastante, 
    pois é possivel ter index negativos
    Todo: Montar o comentário de cima pq eu sou um animal
]]--

function DoubleLinkedList.new()
    return nil
end

function DoubleLinkedList.append_left(list, value)
    local node = {before = nil, next = nil, info = value}
    if not list then
        return node
    end

    local to_append = list
    while to_append.before do
        to_append = to_append.before
    end
    to_append.before = node
    node.next = to_append
    return list
end

function DoubleLinkedList.append_right(list, value)
    local node = {before = nil, next = nil, info = value}
    if not list then
        return node
    end
    local to_append = list
    while to_append.next do
        to_append = to_append.next
    end
    to_append.next = node
    node.before = to_append
    return list
end

function DoubleLinkedList.free(list)
    for k, v in pairs(list) do
        list[k] = nil
    end
    return nil
end

function DoubleLinkedList.print(list)
    local tmp_list = list
    while tmp_list do
        print(tmp_list.info)
        tmp_list = tmp_list.next
    end
end

function DoubleLinkedList.convert_values_to_string(list)
    local str = ""
    local next = list

    if not list then
        return str
    end

    while next.before do
        next = next.before
    end

    while next do
        str = str  .. "" .. next.info
        next = next.next
    end
    return str
end

function Set.new(t)
    local set = {}
    setmetatable(set, Set.mt)
    for _, l in ipairs(t) do
        set[l] = true
    end
    return set
end

function Set.intersction(a,b)
    local result = Set.new({})
    for k in pairs(a) do
        if b[k] then
            result[k] = b[k]
        end
    end
    return result
end

function Set.contains_any(a, b)
    for index, _ in pairs(a) do
        if b[index] then
            return true
        end
    end
    return false
end

Set.mt.__bor = Set.contains_any -- Permite usar a | b ao invés de Set.contais_any(a, b)
Set.mt.__mul = Set.intersction -- Permite usar a * b ao in vés de Set.intersection(a, b)

data_structures.Set = Set
data_structures.DoubleLinkedList = DoubleLinkedList

return data_structures