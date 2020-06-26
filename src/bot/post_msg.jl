using ConfParser, HTTP, JSON2

conf = ConfParse("confs/config.ini")
parse_conf!(conf)

token     = retrieve(conf, "telegram", "token")
chat_id   = retrieve(conf, "telegram", "chat_id")

function post_forex_prediction()::Int64
    request_query = create_request_text(chat_id, "hello")
    return telegram_request(token, request_query)
end

function create_request_text(id, text; message_id = "")::String
    # can't pass empty text, results 400
    text = text |> HTTP.URIs.escapeuri #encode for GET purpose
    id = id |> HTTP.URIs.escapeuri #encode for GET purpose
    request_query = ""
    message_id == "" ? request_query = """chat_id=$id&text=$text""" :
    request_query = """chat_id=$id&text=$text&reply_to_message_id=$message_id"""
    return request_query
end

function telegram_request(bot_token::String, query::String)::Int64
    try
        updates = HTTP.request(
            "GET",
            "https://api.telegram.org/$bot_token/sendMessage";
            query = "$query",
        )
        return 200
    catch e
        errmsg = JSON2.parse(String(e.response.body))
        @warn "$(errmsg["description"]): $id"
        return 500
    end
    sleep(0.01)
end
