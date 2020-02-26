using NonlinearTestProblems
using Test

const SQUARE_PROBLEMS = [F_NWp281(), Rosenbrock(), PowellSingular(), PowellBadlyScaled(),
                         HelicalValley()]

@testset "basic consistency checks for test functions." begin
    for f in SQUARE_PROBLEMS
        x = root(f)
        @test length(x) == domain_dimension(f) == range_dimension(f)
        @test all(lower_bounds(f) .≤ x .≤ upper_bounds(f))
        @test sum(abs2, f(x)) ≤ eps()
        x′ = starting_point(f)
        @test length(x′) == length(x)
        @test sum(abs2, f(x′)) > eps()
    end
end
