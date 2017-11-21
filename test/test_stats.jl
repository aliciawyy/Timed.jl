using Base.Test
using Timed

function test_dist1()
    @test_approx_eq dist1([1, 2, 3], [1, 2, 3.]) == 1
end
