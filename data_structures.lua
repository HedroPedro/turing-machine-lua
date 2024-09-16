Set = {}
Set.mt = {}
DoubleLinkedList = {}

--[[
    Para todo mundo que decidir ver o meu código, não precisa usar isso,
    uma table semelhante a {array[], atual}, já era o bastante, 
    pois é possivel ter index negativos
    Todo: Montar o comentário de cima pq eu sou um animal
]]

function DoubleLinkedList.new()
    return nil
end

function DoubleLinkedList.append_left(list, value)
    local node = {before = nil, next = list, value = value}
    return node
end

function DoubleLinkedList.append_right(list, value)
    local node = {before = nil, next = nil, value = value}
    local tmp_list = list
    while tmp_list.next do
        tmp_list = tmp_list.next
    end
    tmp_list.next = node
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
        print(tmp_list.value)
        tmp_list = tmp_list.next
    end
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
    local result = Set.new()
    for k in pairs(a) do
        result[k] = b[k]
    end
    return result
end

function Set.contains(a, b)
    for k in pairs(a) do
        if b[k] then
            return true
        end
    end
    return false
end

Set.mt.__bor = Set.contains
Set.mt.__mul = Set.intersction