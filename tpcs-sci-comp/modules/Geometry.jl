module Geometry
export Point, x_coord, y_coord, distance, Polygon, perimeter, printPolyAsTuples, plot, area, isValid

using Gadfly

dark_theme = Theme(
    panel_fill=colorant"black",
    default_color=colorant"red",
    line_width=3pt,
    default_point_size=3.5pt,
    lowlight_opacity=0.7
);

type Point
    x::Int
    y::Int
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

type Polygon
    points::Array{Point,1}
    Polygon(p::Array{Point,1})=new(p)
end

function __perimeter(poly::Polygon)
    pts,pts_size = isValid(poly)
    p = 0; # perimeter variable

  # BEGIN SORT >
    #=
    ptsX = map(x_coord, s3.points)
    ptsY = map(y_coord, s3.points)
    ptsA = [ptsX ptsY]
    p1=sortrows(ptsA, by=x->(x[2],x[1]))
    pts = []

    for i=1:length(p1[:,1])
        push!(pts,Point(p1[i],p1[length(p1[:,1])+i]))
    end
    =#
  # < END SORT

    for i = 1:pts_size-1
       p += sqrt((pts[i+1].x-pts[i].x)^2+(pts[i+1].y-pts[i].y)^2)
    end
    p += sqrt((pts[pts_size].x-pts[1].x)^2+(pts[pts_size].y-pts[1].y)^2)
    p
end

function perimeter(poly::Polygon)
    pts,pts_size = isValid(poly)
    p = 0; # perimeter variable

    for i = 1:pts_size-1
       p += distance(pts[i+1],pts[i])
    end
    p += distance(pts[pts_size],pts[1])
    p
end

function printPolyAsTuples(poly::Polygon)
  ptsX = map(x_coord, poly.points)
  ptsY = map(y_coord, poly.points)
  ptsA = [ptsX ptsY]

  # p1=sortrows(ptsA, by=x->(x[1], x[2]))

  p1=ptsA
  for i=1:length(p1[:,1])
      print((p1[i],p1[length(p1[:,1])+i])," ")
  end
end

function isValid(poly::Polygon)
    pts = poly.points
    pts_size = length(pts)
    pts_size>=3 || throw(ArgumentError("Not a valid shape. Polygons have at least 3 points."))
    return pts,pts_size
end

function plot(poly::Polygon)
    isValid(poly)
    ptsX = map(x_coord, poly.points)
    ptsY = map(y_coord, poly.points)
    ptsA = [ptsX ptsY]
    Gadfly.plot(x=ptsX, y=ptsY, Geom.polygon, dark_theme)
end

function area(poly::Polygon)
    pts,pts_size = isValid(poly)
    area = 0; # area variable

    for i = 1:pts_size-1
        area+=((x_coord(pts[i])*y_coord(pts[i+1])) - (y_coord(pts[i])*x_coord(pts[i+1])))
    end

    abs(area/2)
end

end
