using Carrot
using Test
include("./bot/post_msg_tests.jl")

@testset "launch" begin
    @test "batch bot" == Carrot.launch("batchBot")
    @test "forex predict" == Carrot.launch("forexPredict")
    @test "web" == Carrot.launch("web")
    @test "unknown" == Carrot.launch("balabala")
end

@testset "feature_mappings" begin
    @test Carrot.get_feature_mappings()["batchBot"] == 0
end
