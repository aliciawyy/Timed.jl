function dist1(x, y)
    return sum(abs.(x - y))
end

function dist2(x, y)
    diff = x - y
    return sum(diff .* diff)
end
