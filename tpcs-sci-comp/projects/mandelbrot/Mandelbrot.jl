module Mandelbrot

export MandelbrotView, newton, iterate, is_in_mbset, leaving_number, plot

using Images, Colors, ImageView

type MandelbrotView
  min::Number
  max::Number
  N::Int64

  MandelbrotView()=new(Complex(0),Complex(0),0); #throw(ArgumentError("Invalid Mandelbrot: Need at least a min and max"))
  MandelbrotView(min, max)=new(Complex(min),Complex(max),255);
  MandelbrotView(min, max, N)=new(Complex(min),Complex(max),N);
end

function newton(f,df,x0)
  local found = false, x=x0,n=0
  while(!found && n<50)
    n+=1
    x=x-f(x)/df(x)
    found = abs(f(x))<1.0e-12
  end
  return x
end

function iterate(z::Number,iter::Int64=255)
  local c = z
  local leaving = iter
  local arr=Complex[]
  local lnum = 255
  for n = 1:leaving
    c = z
    if abs(z) > 2
      lnum = n
      return arr, lnum
    else
      lnum = 255
    end
    z = z^2 + c
    push!(arr,z)
  end
  return arr, lnum
end

function is_in_mbset(c::Complex)
  local mb = iterate(c)
  return mb[2] == 255
end

function leaving_number(c::Complex,iter::Int64=10,ipoint::Complex=0+0im)
  local out = iterate(c,iter);
  return out[2]
end

function plot(m::MandelbrotView,scale::Number=1)
  local height = 400*scale
  local width = 600*scale
  local z=[(x+y*im) for x=-2:3/(height-1):1, y=1:-2/(width-1):-1]
  local y=map(x->leaving_number(x),z)
  y=map(x->UInt8(x),y)
  return ImageCmap(y,colormap("RdBu",256))
end

end
