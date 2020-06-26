using Test
using HTTP
using JSON2
using Carrot
using Mocking

Mocking.activate()

response = "{\"instrument\":\"EUR_USD\",\"granularity\":\"H1\",\"candles\":[{\"complete\":true,\"volume\":1013,\"time\":\"2020-06-26T04:00:00.000000000Z\",\"mid\":{\"o\":\"1.12227\",\"h\":\"1.12264\",\"l\":\"1.12211\",\"c\":\"1.12238\"}}]}"
data = JSON2.read(response)

@testset "fetch_data" begin
    @test create_time_series_metrix(data.candles) ==
          [1.12227 1.12264 1.12211 1.12238 1013.0]
    patch = @patch HTTP.request(a::String, b::String, c::Dict{String,String}; query="granularity=H1&count=1500", readtimeout=2) = HTTP.Response(200, body=Vector{UInt8}(response))
    apply(patch) do
        @test getCandles("EUR_GBP", "H1") == [1.12227 1.12264 1.12211 1.12238 1013.0]
    end

end
