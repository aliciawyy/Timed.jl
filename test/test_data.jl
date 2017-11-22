@testset "TimedData" begin
    timestamp = DateTime(2017, 11, 22)
    tickers = [:SHY, :SPY, :EWJ]
    prices = [84.50, 248.03, 38.20]

    @test_throws ArgumentError TimedData(timestamp, tickers, [100.10, 200.02])
    @test_throws ArgumentError TimedData(timestamp, [:SHY, :SPY, :SPY], prices)

    timed_data = TimedData(timestamp, tickers, prices)
    @test timed_data.timestamp == timestamp
    @test timed_data.keys == tickers
    @test timed_data.values == prices

    @test timed_data == TimedData("2017-11-22", tickers, prices)

    for i = 1:3
        expected = prices[i]
        @test timed_data[i] == expected
        @test timed_data[tickers[i]] == expected
    end

    @test timed_data[[:SPY, :EWJ]] == [248.03, 38.20]
    @test timed_data[[1, 3]] == [84.50, 38.20]

    @testset "add_and_prod" begin
        timed_data15 = TimedData(timestamp, tickers, prices .* 1.5)
        @test timed_data * 1.5 == timed_data15
        @test 1.5 * timed_data == timed_data15

        timed_data2 = TimedData(timestamp, [:SPY, :QQQ], [100., 200])
        all_tickers = [:EWJ, :QQQ, :SHY, :SPY]
        expected_sum = TimedData(
            timestamp, all_tickers, [38.20, 200., 84.50, 348.03]
        )
        @test timed_data + timed_data2 == expected_sum
        timed_data3 = TimedData("2017-11-01", [:SPY], [100.])
        @test_throws ArgumentError timed_data + timed_data3

        timed_data_list = [timed_data, timed_data15, timed_data2]
        coef_list = [1., 10., 5.]
        result = mapreduce(prod, +, zip(coef_list, timed_data_list))
        expected = TimedData(
            timestamp, all_tickers, [611.2, 1000.0, 1352.0, 4468.48]
        )
        @test result == expected
    end
end
