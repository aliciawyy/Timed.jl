@testset "TimedData" begin
    timestamp = DateTime(2017, 11, 22)
    tickers = [:SHY, :SPY, :EWJ]
    prices = [84.50, 248.03, 38.20]
    timed_data = TimedData(timestamp, tickers, prices)

    @test timed_data.timestamp == timestamp
    @test timed_data.keys == tickers
    @test timed_data.values == prices
end
