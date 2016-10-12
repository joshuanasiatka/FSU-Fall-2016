module StatsPackage
export the_mean, the_std

function the_mean(x::Number,y::Number)
  (x+y)/2
end

function the_mean(x::Number,y::Number,z::Number)
  (x+y+z)/3
end

function the_mean(x::Number...)
  sum(x)/length(x)
end

function the_mean(r::UnitRange)
  sum(r)/length(r)
end

function the_mean(r::FloatRange)
  sum(r)/length(r)
end

function the_mean(arr::Array{Int64,1})
  sum(arr)/length(arr)
end

function the_mean(arr::Array{Float64,1})
  sum(arr)/length(arr)
end

function the_std(arr::Array{Int64,1})
  sqrt(reduce(+,map(a->(a-the_mean(arr))^2,arr))/(length(arr)-1))
end

function the_std(arr::Array{Float64,1})
  sqrt(reduce(+,map(a->(a-the_mean(arr))^2,arr))/(length(arr)-1))
end

end
