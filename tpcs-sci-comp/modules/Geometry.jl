module Geometry
export Point, x_coord, y_coord, distance, Polygon, perimeter, printPolyAsTuples, plot, area, isValid, rectangle

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
    Polygon(p::Array{Point,1})=length(p)>2?new(p):throw(ArgumentError("Invalid Polygon. Must be 3 or more points."))
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
    pts,pts_size=isValid(poly)
    ptsX = map(x_coord, pts)
    ptsY = map(y_coord, pts)
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

function rectangle(poly::Polygon)
    pts,pts_size=isValid(poly)
    pts_size==4||throw(ArgumentError("A rectangle as four points, that does not."))
    Ax=pts[1].x;   Ay=pts[1].y;
    Bx=pts[2].x;   By=pts[2].y;
    Cx=pts[3].x;   Cy=pts[3].y;
    Dx=pts[4].x;   Dy=pts[4].y;
    (((Ax==Dx)&&(Ay==By)&&(Bx==Cx)&&(Cy==Dy))  ||
     ((Ax==Bx)&&(Ay==Dy)&&(By==Cy)&&(Cx==Dx))) || throw(ErrorException("Sorry. Not a rectangle."))
    ### Original Attempt
    # AB=distance(A,B)
    # BC=distance(B,C)
    # CD=distance(C,D)
    # DA=distance(D,A)
    # AC=distance(A,C)
    # BD=distance(B,D)
    # ((AB==CD&&BC==DA)&&(AC==BD)&&())||throw(ErrorException("Sorry. Not a rectangle."))
    ###
end

end
