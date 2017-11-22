using Base.Dates

struct TimedData
    timestamp::DateTime
    keys::Vector{Symbol}
    values::Vector

    function TimedData(timestamp::DateTime, keys_::Vector{Symbol},
                       values_::Vector)
        if length(keys_) != length(values_)
            msg = "keys=$keys_ and values=$values_ should have the same size!"
            throw(ArgumentError(msg))
        elseif !allunique(keys_)
            msg = "keys=$keys_ should not contain duplicates!"
            throw(ArgumentError(msg))
        end
        new(timestamp, keys_, values_)
    end

    function TimedData(timestamp::String, keys_::Vector{Symbol},
                       values_::Vector)
        new(DateTime(timestamp), keys_, values_)
    end
end

get_value(d::TimedData, key::Symbol) = d.values[d.keys .== key][1]
get_value(d::TimedData, index::Int) = d.values[index]
get_value(d::TimedData, keys_::Vector) = map(key -> get_value(d, key), keys_)

function Base.:*(d::TimedData, num::Number)
    TimedData(d.timestamp, d.keys, d.values .* num)
end
Base.:*(num::Number, d::TimedData) = d * num

function Base.:(==)(x::TimedData, y::TimedData)
    x.timestamp == y.timestamp && x.keys == y.keys && x.values == y.values
end

function Base.:+(x::TimedData, y::TimedData)
    x_ = Dict(zip(x.keys, x.values))
    y_ = Dict(zip(y.keys, y.values))
    overall = merge(+, x_, y_)
    keys_ = sort(collect(keys(overall)))
    values_ = map(k -> overall[k], keys_)
    TimedData(x.timestamp, keys_, values_)
end
