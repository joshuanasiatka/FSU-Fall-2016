function count_heads(n::Int)
    c::Int = 0
    for i=1:n
        c += rand(Bool)
    end
    c
end

function count_heads(n::Float64)
    c::Int = 0
    for i=1:n
        c += rand(Bool)
    end
    c
end
