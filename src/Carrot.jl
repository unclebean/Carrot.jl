module Carrot

@enum Features batchBot forexPredict web

function launch(feature::String)
    if feature == string(batchBot)
        return "batch bot"
    elseif feature == string(forexPredict)
        return "forex predict"
    elseif feature == string(web)
        return "web"
    else
        return "unknown"
    end
end


end
