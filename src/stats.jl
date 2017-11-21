function dist1(x::Vector, y::Vector)
    return sum(abs.(x - y))
end

function dist2(x::Vector, y::Vector)
    diff = x - y
    return sum(diff .* diff)
end
