module TSP

export total_distance, open_JSON, permute_travels, run_TSP, map_parse, render_map

using Combinatorics, JSON

function total_distance(nodes::Array{Int,1}, distances::Array{Float64,2})
    local sum = 0.0;
    for i=1:length(nodes)-1
        sum += distances[nodes[i],nodes[i+1]]
    end
    sum + distances[nodes[1], nodes[end]]
    ## return the total distance through the graph given by passing through the given nodes
end

function open_JSON(file::String)
    f=open(file,"r")
    dist=JSON.parse(f)
    close(f)

    return dist
end

function map_parse(arr::Dict{String,Any})
    local row = length(arr["destination_addresses"])
    local col = length(arr["origin_addresses"])
    local dist_arr = zeros(Float64,row,col)
    for i=1:row
        for j=1:col
            dist_arr[i,j] = arr["rows"][j]["elements"][i]["distance"]["value"]
        end
    end

    return dist_arr
end

function permute_travels(arr::Array{Float64,2})
    local len = Int64(sqrt(length(arr)))
    local permutations = map(k->nthperm(collect(1:len), k), collect(1:factorial(len)))
    local distances = map(k->total_distance(k,arr),permutations)

    return distances
end

function run_TSP(filename::String)
    local file = open_JSON(filename)
    local dist_map = map_parse(file)
    local permutations = permute_travels(dist_map)
    local min_distance = findmin(permutations)
    local that_path = map(x->file["destination_addresses"][x],nthperm(collect(1:length(file["rows"])),min_distance[2]))
    print("The Shortest Distance and Position is: ", min_distance)
    print("\n\nThe path of which is: \n", that_path)
    return min_distance, that_path
end

function run_TSP(dist_map::Array{Float64,2})
    # local dist_map = map_parse(arr)
    local permutations = permute_travels(dist_map)
    local min_distance = findmin(permutations)
    print("The Shortest Distance and Position is: ", min_distance)
    return min_distance
end

function render_map(filename::String)
    local file = open_JSON(filename)
    local dist_map = map_parse(file)
    return dist_map
end

end

#=
Fitchburg, MA |
Boston, MA |
Fall River, MA  |
Lowell, MA |
North Adams, MA  |
Springfield, MA |
Worcester, MA

Amherst, MA |
Braintree, MA |
Lawrence, MA |
Natick, MA |
Pittsfield, MA |
Provincetown, MA |
Salem, MA |
Woburn, MA
=#
