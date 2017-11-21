@testset "TimedData" begin
    timestamp = DateTime(2017, 11, 22)
    tickers = [:SHY, :SPY, :EWJ]
    prices = [84.50, 248.03, 38.20]
    timed_data = TimedData(timestamp, tickers, prices)

    @test_throws ArgumentError TimedData(timestamp, tickers, [100.10, 200.02])
    @test timed_data.timestamp == timestamp
    @test timed_data.keys == tickers
    @test timed_data.values == prices

    for i = 1:3
        expected = prices[i]
        @test get_value(timed_data, i) == expected
        @test get_value(timed_data, tickers[i]) == expected
    end

    @test get_value(timed_data, [:SPY, :EWJ]) == [248.03, 38.20]
    @test get_value(timed_data, [1, 3]) == [84.50, 38.20]
end
