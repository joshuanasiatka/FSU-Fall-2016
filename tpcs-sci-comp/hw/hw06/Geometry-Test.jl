### check to see if the current directory is in the load path and if not, load it.
if !("." in LOAD_PATH)
    push!(LOAD_PATH,".")
end

using Geometry
using Base.Test

function is_equal(p1::Point, p2::Point)
  ((p1.x==p2.x) && (p1.y==p2.y))?true:false
end


## test the creation of a card
pt1=Point(-5,-5)
pt2=Point(-5,-5)
pt3=Point(5,5)
pt4=Point(5,-37)
poly1=Polygon([pt1,pt2,pt3,pt4])
poly2=Polygon([Point(5,-5),Point(-5,-5),Point(-5,5),Point(5,5)])

@testset "Polygon Tests" begin

    @testset "Legal Point Constructor" begin
        @test isa(Point(1,3),Point)
        @test isa(pt4,Point)
        @test isa(Point(-15,-3),Point)
    end
    @testset "Legal Polygon Constructor" begin
        @test isa(Polygon([Point(1,2),Point(2,3),Point(3,-4)]),Polygon)
        @test isa(Polygon([Point(-5,5),Point(5,5),Point(5,-5),Point(-5,-5)]),Polygon)
    end
    @testset "Illegal Polygon throws exceptions" begin
        @test_throws ArgumentError Polygon([Point(0,0)])            ## Only a point
        @test_throws ArgumentError Polygon([Point(1,2),Point(2,3)]) ## Just a line
    end
    @testset "Point Tests" begin
        @test isa(pt1, Point)
        @test is_equal(pt1,pt2)
    end

    @testset "Distance Test" begin
        @test distance(pt1, pt1)==0
        @test distance(pt1, pt3)==14.142135623730951
    end

    @testset "Rectangle Test" begin
        @test rectangle(poly2)
        @test_throws ErrorException rectangle(poly1)
    end

    @testset "Perimeter Test" begin
        @test perimeter(poly2)==40
        @test perimeter(poly1)==89.66824485221137
    end

end
