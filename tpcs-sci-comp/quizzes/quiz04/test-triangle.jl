### this file tests the Quad module

### check to see if the current directory is in the load path and if not, load it.  
if !("." in LOAD_PATH)
    push!(LOAD_PATH,".")
end

using Geometry
using Base.Test


## test the creation of a card


t1=Triangle(Point(0,0),Point(4,0),Point(4,3))
t2=Triangle(Point(-2,0),Point(2,0),Point(0,2*sqrt(3)))
t3=Triangle(Point(1,0),Point(5,4),Point(3,6))
t4=Triangle(Point(-1.5,2.5),Point(0,7/3),Point(6,6))

@testset "Triangle Tests" begin
   
    @testset "Triangle Constructor" begin
        @test isa(t1,Triangle)
        @test isa(t2,Triangle)
        @test isa(t3,Triangle)
        @test isa(t4,Triangle)
    end
    @testset "Equilateral Triangles" begin
        @test !is_equilateral(t1)
        @test is_equilateral(t2)
        @test !is_equilateral(t3)
        @test !is_equilateral(t4)
    end
    @testset "Right Triangle Tests" begin
        @test is_right(t1)
        @test !is_right(t2)
        @test is_right(t3)
        @test !is_right(t4)
    end    
end
