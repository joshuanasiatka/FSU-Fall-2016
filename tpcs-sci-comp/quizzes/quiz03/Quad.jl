module Quad

export Quadratic, roots, +, -, isequal

import Base.isequal, Base.+, Base.-

type Quadratic
  a::Number
  b::Number
  c::Number
  Quadratic(a::Number, b::Number, c::Number) = new(a,b,c)
end

function roots(q1::Quadratic)
  d = sqrt((q1.b)^2 - 4*(q1.a)*(q1.c))
  return (-q1.b+d)/(2*q1.a),(-q1.b-d)/(2*q1.a)
end

function +(q1::Quadratic, q2::Quadratic)
  return Quadratic(q1.a+q2.a,q1.b+q2.b,q1.c+q2.c)
end

function -(q1::Quadratic, q2::Quadratic)
  return Quadratic(q1.a-q2.a,q1.b-q2.b,q1.c-q2.c)
end

function isequal(q1::Quadratic, q2::Quadratic)
  return (q1.a==q2.a && q1.b==q2.b && q1.c==q2.c)
end

end
