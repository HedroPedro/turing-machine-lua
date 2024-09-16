Set = {}
Set.mt = {}
DoubleLinkedList = {}

function DoubleLinkedList.new()
    return nil
end

function DoubleLinkedList.append_left(list, value)
    local node = {before = nil, after = list, value = value}
    return node
end

function DoubleLinkedList.append_right(list, value)
    local node = {before = nil, after = nil, value = value}
    local tmp_list = list
    while tmp_list.after do
        tmp_list = tmp_list.after
    end
    tmp_list.after = node
    return list
end

function DoubleLinkedList.print(list)
    local tmp_list = list
    while tmp_list do
        print(tmp_list.value)
        tmp_list = tmp_list.after
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