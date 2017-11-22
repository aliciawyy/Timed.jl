dist1(x::Vector, y::Vector) = sum(abs.(x - y))

function dist2(x::Vector, y::Vector)
    diff = x - y
    sum(diff .* diff)
end
