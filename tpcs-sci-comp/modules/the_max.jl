module MaxPackage
export the_max

function the_max(x::Number,y::Number)
    x>y?x:y
end

function the_max(x::Number...)
    max = -Inf
    for num in x
        if num>max
            max=num
        end
    end
    max
end

function the_max(arr::Array{Number,1})
    max = -Inf
    for num in arr
        if num>max
            max=num
        end
    end
    max
end

function the_max(r::UnitRange)
    last(r)
end

function the_max(r::FloatRange)
    last(r)
end

end
