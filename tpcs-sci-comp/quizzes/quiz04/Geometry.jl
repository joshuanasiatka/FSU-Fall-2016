module Geometry
export Point, Triangle, x_coord, y_coord, distance, Polygon, isValid, is_equilateral, is_right

type Point
    x::Number
    y::Number
end

type Polygon
    points::Array{Point,1}
    Polygon(p::Array{Point,1})=length(p)>2?new(p):throw(ArgumentError("Invalid Polygon. Must be 3 or more points."))
end

type Triangle
    a::Point
    b::Point
    c::Point
end

function x_coord(p::Point)
    return p.x
end

function y_coord(p::Point)
    return p.y
end

function distance(pt1::Point, pt2::Point)
    return sqrt((pt2.x-pt1.x)^2+(pt2.y-pt1.y)^2)
end

function isValid(poly::Polygon)
    pts = poly.points
    pts_size = length(pts)
    pts_size>=3 || throw(ArgumentError("Not a valid shape. Polygons have at least 3 points."))
    return pts,pts_size
end

function is_equilateral(t::Triangle)
    isapprox(distance(t.a,t.b),distance(t.b,t.c)) && isapprox(distance(t.a,t.c),distance(t.b,t.c))
end

function is_right(t::Triangle)
    isapprox(distance(t.a,t.b)^2+distance(t.b,t.c)^2,distance(t.a,t.c)^2)?true:isapprox(distance(t.b,t.a)^2+distance(t.a,t.c)^2,distance(t.b,t.c)^2)?true:isapprox(distance(t.c,t.b)^2+distance(t.a,t.c)^2,distance(t.a,t.b)^2)?true:false
end

end
