TOL = 1e-10

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

Base.Dict(d::TimedData) = Dict(zip(d.keys, d.values))

Base.getindex(d::TimedData, key::Symbol) = d.values[d.keys .== key][1]
Base.getindex(d::TimedData, index::Int) = d.values[index]
Base.getindex(d::TimedData, index::Vector{Int}) = d.values[index]
Base.getindex(d::TimedData, keys_::Vector{Symbol}) = getindex(
    d, indexin(keys_, d.keys)
)

function Base.:*(d::TimedData, num::Number)
    TimedData(d.timestamp, d.keys, d.values .* num)
end
Base.:*(num::Number, d::TimedData) = d * num

function Base.:(==)(x::TimedData, y::TimedData)
    is_info_match = x.timestamp == y.timestamp && x.keys == y.keys
    is_info_match && dist1(x.values, y.values) < TOL
end

function Base.:+(x::TimedData, y::TimedData)
    if x.timestamp != y.timestamp
        msg = """Cannot add two data of different timestamps:
                 x=$(x.timestamp) y=$(y.timestamp)"""
        throw(ArgumentError(msg))
    end
    overall = merge(+, Dict(x), Dict(y))
    keys_ = sort(collect(keys(overall)))
    values_ = map(k -> overall[k], keys_)
    TimedData(x.timestamp, keys_, values_)
end
