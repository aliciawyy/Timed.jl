using Base.Test
using Timed

function test_dist1()
    @test dist1([1, 2, 3], [1, 2, 3.]) == 1
end
