module Mandelbrot

export MandelbrotView, newton, iterate, is_in_mbset, leaving_number, plot, plot_zoom

using Images, Colors, ImageView

type MandelbrotView
  min::Number
  max::Number
  #N::Int64
  nx::Int64
  ny::Int64

  MandelbrotView()=new(-2-im,1+im,600,400); #throw(ArgumentError("Invalid Mandelbrot: Need at least a min and max"))
  MandelbrotView(min, max)=new(Complex(min),Complex(max),600,400);
  MandelbrotView(min, max, nx, ny)=new(Complex(min),Complex(max),nx,ny);
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
    # c = z
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
  return iterate(c)[2] == 255
end

function leaving_number(c::Complex,iter::Int64=10,ipoint::Complex=0+0im)
  return iterate(c,iter)[2];
end

#=
function plot(m::MandelbrotView,scale::Number=1)
  local height = 400*scale
  local width = 600*scale
  local z=[(x+y*im) for x=-2:3/(height-1):1, y=1:-2/(width-1):-1]
  local y=map(x->leaving_number(x),z)
  y=map(x->UInt8(x),y)
  return ImageCmap(y,colormap("RdBu",256))
end


function complex_newton(zmin::Complex, zmax::Complex,nx::Int=50,ny::Int=50)
    local dx = ((real(zmax)-real(zmin))/(nx-1))
    local dy = ((imag(zmin)-imag(zmax))/(ny-1))
    local Z=[x+y*im for y=imag(zmax):dy:imag(zmin), x=real(zmin):dx:real(zmax)]
    local roots = map(a->newton(z->z^3-1,z->3z^2,a),Z)
    local angles = round(map(angle,roots)*180/pi)
    angles[find(isnan,angles)]=0.0
    local datas=div(convert(Array{Int,2},angles)+240,120)
    local cmap = colormap("Blues", 3)
    return ImageCmap(transpose(datas),cmap)
end
=#

function plot(xy::MandelbrotView)
    local dx = (real(xy.max)-real(xy.min))/(xy.nx-1)
    local dy = (imag(xy.min)-imag(xy.max))/(xy.ny-1)
    local Z=[x+im*y for y = imag(xy.max):dy:imag(xy.min),x=real(xy.min):dx:real(xy.max)]
    local img_map = (map(x->(leaving_number(x,255)),Z))
    local cmap = colormap("RdBu", 256)
    return ImageCmap(transpose(img_map),cmap)
end

function plot_zoom(xy::MandelbrotView,shiftUD::Number=0,shiftLR::Number=0,zoom::Number=1.0)
    -1<=shiftUD&&shiftUD<=1?true:throw(ArgumentError("Invalid Up/Down Shift: Must be between -1 and 1"))
    -2<=shiftLR&&shiftLR<=1?true:throw(ArgumentError("Invalid Left/Right Shift: Must be between -2 and 1"))
    local dx = (real(xy.max)-real(xy.min))/(xy.nx-1)
    local dy = (imag(xy.min)-imag(xy.max))/(xy.ny-1)
    local Z=[(x+(shiftLR*zoom))+im*(y+(shiftUD*zoom)) for y = imag(xy.max):dy:imag(xy.min),x=real(xy.min):dx:real(xy.max)]
    Z*=abs(1/zoom)
    local img_map = (map(x->(leaving_number(x,255)),Z))
    local cmap = colormap("RdBu", 256)
    return ImageCmap(transpose(img_map),cmap)
end

end
