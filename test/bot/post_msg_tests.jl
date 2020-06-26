using Test
using Carrot

@testset "post_forex_prediction" begin
    @test create_request_text("chat_id", "the message") == "chat_id=chat_id&text=the%20message"
    @test create_request_text("chat_id", "message", message_id="message_id") == "chat_id=chat_id&text=message&reply_to_message_id=message_id"
end
