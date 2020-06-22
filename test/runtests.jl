using Carrot
using Test

@testset "Carrot.jl" begin
    @test "batch bot" == Carrot.launch("batchBot")
    @test "forex predict" == Carrot.launch("forexPredict")
    @test "web" == Carrot.launch("web")
    @test "unknown" == Carrot.launch("balabala")
    # Write your tests here.
end
