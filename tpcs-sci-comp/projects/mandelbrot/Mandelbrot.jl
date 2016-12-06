module Mandelbrot

export MandelbrotView, newton, iterate

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

#=
function iterate(x::Number,c::Complex=im,n::Int64=10)
  local x0 = x
  local iters = []
  local err = "No error defined."
  for i=1:n
    x0 = x0^2+c
    # println("($(x0))^2+$(c) = $(x0^2+c)")
    if abs(x0^2) > 2
      err = "Not bounded."
      return n-1
    else
      err  = "Series is bounded."
    end
    push!(iters,x0)
  end
  println(err)
  return iters
end
=#

function iterate(z::Number,iter::Int64=10)
    local c = z
    local maxiter = iter
    local arr=[]
    err = "No defined error."
    for n = 1:maxiter
        if abs(z) > 2
          err = "Not bounded."
        else
          err  = "Series is bounded."
        end
        z = z^2 + c
        push!(arr,z)
    end
    println(err)
    return arr
end

end
