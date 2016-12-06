### check to see if the current directory is in the load path and if not, load it.
if !("." in LOAD_PATH)
    push!(LOAD_PATH,".")
end

using Mandelbrot
