using HTTP, JSON2
using Mocking

function getForexAPI(endpoint::String)
    return "https://api-fxtrade.oanda.com/$endpoint"
end

function getHeaders()
    token = CarrotConfig["oanda_token"]
    return Dict(
        "Authorization" => "Bearer $token",
        "Accept-Datetime-Format" => "RFC3339",
        "Content-Type" => "application/json",
    )
end

function getAccounts()
    resp = @mock HTTP.request(
        "GET",
        getForexAPI("v3/accounts"),
        getHeaders();
        require_ssl_verification = false,
    )
    return JSON2.read(String(resp.body))
end

function getCandles(
    symbol::String,
    time::String;
    count::Int64 = 1500,
    complete::Bool = true,
)
    resp = @mock HTTP.request(
        "GET",
        getForexAPI("v3/instruments/$symbol/candles"),
        getHeaders();
        query = "granularity=$time&count=$count",
        readtimeout = 2,
    )
    respBody = JSON2.read(String(resp.body))
    if complete
        candles = filter(c -> c.complete == true, respBody.candles)
    else
        candles = respBody.candles
    end

    return create_time_series_metrix(candles)
end

function create_time_series_metrix(candles::Array{Any,1})::Array{Float64,2}
    candlesMatrix = Matrix{Float64}(undef, size(candles)[1], 5)
    for (index, candle) in enumerate(candles)
        mid = candle.mid
        item = [
            parse(Float64, mid.o),
            parse(Float64, mid.h),
            parse(Float64, mid.l),
            parse(Float64, mid.c),
            candle.volume,
        ]
        candlesMatrix[index, :] = item
    end
    return candlesMatrix
end
