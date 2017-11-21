using Base.Dates

struct TimedData
    timestamp::DateTime
    keys::Vector
    values::Vector
end

function get_value(d::TimedData, index::Symbol)
    return d.values[d.keys .== index][1]
end
