using Base.Dates

struct TimedData
    timestamp::DateTime
    keys::Vector
    values::Vector

    function TimedData(timestamp::DateTime, keys::Vector, values::Vector)
        if size(keys) != size(values)
            msg = "keys=$keys and values=$values should have the same size!"
            throw(ArgumentError(msg))
        end
        new(timestamp, keys, values)
    end
end

function get_value(d::TimedData, index::Symbol)
    return d.values[d.keys .== index][1]
end

function get_value(d::TimedData, index::Int)
    return d.values[index]
end

function get_value(d::TimedData, index::Vector)
    return map(i -> get_value(d, i), index)
end
