using Base.Test
using Timed

@test dist1([1, 2, 1], [1, 1, 2]) == 2
@test dist2([1, 3, 3], [1, 2, 2]) == 2
@test dist2([1, 2, 3], [0, 0, 6]) == 14
