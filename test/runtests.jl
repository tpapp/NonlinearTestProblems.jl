using NonlinearTestProblems
using Test

const SQUARE_PROBLEMS = [F_NWp281(), Rosenbrock(), PowellSingular(), PowellBadlyScaled(),
                         HelicalValley()]

@testset "basic consistency checks for test functions." begin
    for f in SQUARE_PROBLEMS
        x0 = root(f)
        @test length(x0) == domain_dimension(f) == range_dimension(f)
        @test all(lower_bounds(f) .≤ x0 .≤ upper_bounds(f))
        @test sum(abs2, f(x0)) ≤ eps()

        x1 = starting_point(f)
        @test length(x1) == length(x)
        @test sum(abs2, f(x1)) > eps()

        @test starting_point(f, 0) ≈ x1
        x2 = starting_point(f, 1)
        @test sum(abs2, x2 .- x0) ≥ sum(abs2, x1 .- x0)
    end
end
