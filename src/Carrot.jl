module Carrot

@enum Features batchBot forexPredict web

function get_feature_mappings()::Dict
    feature_map = Dict()
    for (index, feature) in enumerate(instances(Features))
        feature_map[string(feature)] = index - 1
    end
    return feature_map
end

function launch(command::String)
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
