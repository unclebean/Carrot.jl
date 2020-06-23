using Carrot
using Test

@testset "launch" begin
    @test "batch bot" == Carrot.launch("batchBot")
    @test "forex predict" == Carrot.launch("forexPredict")
    @test "web" == Carrot.launch("web")
    @test "unknown" == Carrot.launch("balabala")
end

@testset "feature_mappings" begin
    @test Carrot.get_feature_mappings()["batchBot"] == 0
end
