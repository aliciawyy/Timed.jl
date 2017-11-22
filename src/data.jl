struct TimedData
    timestamp::DateTime
    keys::Vector{Symbol}
    values::Vector

    function TimedData(timestamp::DateTime, keys::Vector{Symbol},
                       values::Vector)
        key_len = length(keys)
        if key_len != length(values)
            msg = "keys=$keys and values=$values should have the same size!"
            throw(ArgumentError(msg))
        elseif key_len > length(union(keys))
            msg = "keys=$keys should not contain duplicates!"
            throw(ArgumentError(msg))
        end
        new(timestamp, keys, values)
    end

    function TimedData(timestamp::String, keys::Vector{Symbol}, values::Vector)
        new(DateTime(timestamp), keys, values)
    end
end

get_value(d::TimedData, key::Symbol) = d.values[d.keys .== key][1]
get_value(d::TimedData, key::Int) = d.values[key]
get_value(d::TimedData, keys::Vector) = map(key -> get_value(d, key), keys)

function Base.:*(d::TimedData, num::Number)
    TimedData(d.timestamp, d.keys, d.values .* num)
end
Base.:*(num::Number, d::TimedData) = d * num

function Base.:(==)(x::TimedData, y::TimedData)
    x.timestamp == y.timestamp && x.keys == y.keys && x.values == y.values
end

function Base.:+(x::TimedData, y::TimedData)
    overall = Dict(zip(x.keys, x.values))
    map(i -> add(values[i], get_value()))
    TimedData(x.timestamp, keys, values)
end
