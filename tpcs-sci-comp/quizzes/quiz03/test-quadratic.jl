### this file tests the Quad module

### check to see if the current directory is in the load path and if not, load it.  
if !("." in LOAD_PATH)
    push!(LOAD_PATH,".")
end

using Quad
using Base.Test


## test the creation of a card


q1=Quadratic(1,-4,3)
q2=Quadratic(2,0,5)
q3=Quadratic(-3,4,1)

@testset "Playing Card Tests" begin
   
    @testset "Quadratic Constructor" begin
        @test isa(q1,Quadratic)
        @test isa(q2,Quadratic)
        @test isa(q3,Quadratic)
    end
    @testset "adding/subtracting quadratics" begin
        @test isequal(q1+q2,Quadratic(3,-4,8))
        @test isequal(q1+q3,Quadratic(-2,0,4))
        @test isequal(q1-q3,Quadratic(4,-8,2))
        @test isequal(q3-q1,Quadratic(-4,8,-2))
    end
    @testset "Check the roots" begin
        x,y=roots(q1)
        @test isapprox(x,3)&&isapprox(y,1) || isapprox(x,1) && isapprox(y,3)
    end    
end



