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

get_value(d::TimedData, key::Symbol) = d.values[d.keys .== key][1]
get_value(d::TimedData, key::Int) = d.values[key]
get_value(d::TimedData, keys::Vector) = map(key -> get_value(d, key), keys)
