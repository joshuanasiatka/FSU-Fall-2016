### check to see if the current directory is in the load path and if not, load it.
if !("." in LOAD_PATH)
    push!(LOAD_PATH,".")
end

using Mandelbrot, Base.Test

## test the creation of a MandelbrotViews

m1 = MandelbrotView()
m2 = MandelbrotView(-2-im,1+im)

n1 = -im
n2 = -1.01im
n3 = 0.4+0.0im
n4 = -0.5+0.5im
n5 = 2im

@testset "Mandelbrot Tests" begin

    @testset "Mandelbrot Constructor" begin
        @test isa(m1,MandelbrotView)
        @test isa(m2,MandelbrotView)
    end
    @testset "In Mandelbrot Set" begin
        @test is_in_mbset(n1)
        @test !is_in_mbset(n2)
        @test !is_in_mbset(n3)
        @test is_in_mbset(n4)
        @test !is_in_mbset(n5)
    end
end
