using NonlinearTestProblems
using Test

const SQUARE_PROBLEMS = [F_NWp281(), Rosenbrock(), PowellSingular(), PowellBadlyScaled(),
                         HelicalValley()]

const RECTANGULAR_PROBLEMS = [Beale()]

@testset "basic consistency checks for test functions." begin
    for f in vcat(SQUARE_PROBLEMS, RECTANGULAR_PROBLEMS)
        x0 = root(f)
        @test length(x0) == domain_dimension(f)
        @test all(lower_bounds(f) .≤ x0 .≤ upper_bounds(f))
        fx0 = @inferred f(x0)
        @test length(fx0) == range_dimension(f)
        @test sum(abs2, fx0) ≤ eps()

        x1 = starting_point(f)
        @test length(x1) == domain_dimension(f)
        @test sum(abs2, f(x1)) > eps()

        @test starting_point(f, 0) ≈ x1
        x2 = starting_point(f, 1)
        @test sum(abs2, x2 .- x0) ≥ sum(abs2, x1 .- x0)
    end
end
