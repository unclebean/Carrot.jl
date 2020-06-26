module Carrot

include("./bot/post_msg.jl")

# post_msg.jl
export post_forex_prediction, create_request_text

@enum Features batchBot forexPredict web

function get_feature_mappings()::Dict
    feature_map = Dict()
    for (index, feature) in enumerate(instances(Features))
        feature_map[string(feature)] = index - 1
    end
    return feature_map
end

function launch(command::String)
    @info "command is $command"
    features = get_feature_mappings()
    if haskey(features, command)
        feature = features[command]
        return launch(Val(Features(feature)))
    end
    return "unknown"
end

function launch(::Val{batchBot})
    return "batch bot"
end

function launch(::Val{forexPredict})
    return "forex predict"
end

function launch(::Val{web})
    return "web"
end

end
