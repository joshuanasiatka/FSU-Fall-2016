module TSP

export total_distance, open_JSON, permute_travels, run_TSP, map_parse, render_map, sim_annealing, swapEls!

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
    push!(that_path,that_path[1])
    print("The Shortest Distance and Position is: ", min_distance, "\n")
    # print("Which translates to: ", min_distance[1]*0.000621371, " miles.")
    print("\n\nThe path of which is: \n", that_path)
    return min_distance, that_path, dist_map
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

function sim_annealing(distances::Array{Float64,2},iter::Int)
    ### This will run simulated annealing on the TSP and return the
    ###   shortest distance after iter iterations
    local n=size(distances,1)
    local path=collect(1:n)
    local min_path = path
    local min_dist = total_distance(path, distances)

    for i=1:iter
        swapEls!(path, rand(1:n), rand(1:n))
        dist = total_distance(path, distances)
        if (dist < min_dist)
            min_dist = dist
            min_path = path
        end
    end
    return (min_path, min_dist)
end

function swapEls!(A::Array{Int64,1},i::Int,j::Int)
    # swap ith and jth element of some array A
    local temp = A[i];
    A[i] = A[j];
    A[j] = temp;
    return A
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
Newton, MA |
Natick, MA |
Pittsfield, MA |
Plymouth, MA |
Provincetown, MA |
Salem, MA |
Woburn, MA

160 Pearl Street Fitchburg MA |
North Street and Main Street (Fitchburg)|
John Fitch Hwy and Lunenburg Street (Fitchburg)|
South Street and Laurel Street (Fitchburg)|
South Street and Wanoosnoc Rd (Fitchburg)|
Water Street and Bemis Rd (Fitchburg)|
Summer Street and John Fitch Hwy (Fitchburg)|
North Street and Main Street (Lunenburg)|
Main Street and Prospect Street (Lunenburg)|
N. Main Street and Rte 2 (Lunenburg MA)

Merriam Ave and Rte 2 (Lunenburg)|
Haws Street and Commercial Road (Lunenburg)|
45 Sack Blvd, Leominster, MA 01453
=#
