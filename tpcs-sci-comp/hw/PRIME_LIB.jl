module PRIME_LIB
export all_factors, is_prime, next_prime, list_primes, is_perfect, next_perfect

#=
all_factors:  a function that returns all factors of a given positive integer
is_prime:     a function that returns true if positive integer is prime, otherwise false
next_prime:   a function that returns the next larger prime number, bigger than the input positive integer
list_primes:  a function that returns an array of primes between two given inputs
is_perfect:   a function that returns true if a positive integer is perfect, otherwise false
next_perfect: a function that returns the next perfect number larger than a given positive integer
=#

function all_factors(n::Integer)
  factors = [1]
  for i=2:n
    if n%i == 0
      push!(factors,i)
    end
  end
  factors
end

function is_prime(n::Integer)
  length(all_factors(n))==2?true:false
end

function next_prime(n::Integer)
  for i=n+1:2n
    if is_prime(i)
      return i
    end
  end
end

function list_primes(start::Integer, finish::Integer)
    x=[]
    for i=start:finish
        if is_prime(i)
            push!(x,i)
        end
    end
    x
end

function is_perfect(n::Integer)
    factors=all_factors(n)
    sum=0
    for i=1:length(factors)-1
        sum+=factors[i]
    end
    sum==n?true:false
end

function next_perfect(n::Integer)
    for x=n+1:10^9
        if is_perfect(x)
            return x
        end
    end
end

end
