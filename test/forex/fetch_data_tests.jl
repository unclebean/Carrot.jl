using Test
using JSON2
using Carrot

response = "{\"instrument\":\"EUR_USD\",\"granularity\":\"H1\",\"candles\":[{\"complete\":true,\"volume\":1013,\"time\":\"2020-06-26T04:00:00.000000000Z\",\"mid\":{\"o\":\"1.12227\",\"h\":\"1.12264\",\"l\":\"1.12211\",\"c\":\"1.12238\"}}]}"
data = JSON2.read(response)
@testset "fetch_data" begin
    @test create_time_series_metrix(data.candles) == [1.12227 1.12264 1.12211 1.12238 1013.0]
end
