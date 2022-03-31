module NonlinearTestProblems

# export API
export domain_dimension, range_dimension, root, starting_point, lower_bounds, upper_bounds

# export problems
export F_NWp281, Rosenbrock, PowellSingular, PowellBadlyScaled, HelicalValley, Beale

using ArgCheck: @argcheck
using DocStringExtensions: FUNCTIONNAME, SIGNATURES

####
#### generic API
####
#### A *test problem* is a `ℝⁿ → ℝᵐ` mapping with some metadata (roots, starting point,
#### dimension).
####

"""
`$(FUNCTIONNAME)(problem)`

Dimension `n` of a the domain of a ``ℝⁿ → ℝᵐ`` test problem.
"""
function domain_dimension end

"""
$(SIGNATURES)

Dimension `m` of a the range of a ``ℝⁿ → ℝᵐ`` test problem.

!!! note
    Defaults to the domain dimension, only non-square implementations should need to define
    a method.
"""
range_dimension(problem) = domain_dimension(problem)

"""
`$(FUNCTIONNAME)(problem)`

Root (solution) of a test problem. Formally,

```julia
problem(root(problem)) ≈ zeros(range_dimension(problem))
```

Problems are guaranteed to have a unique root.
"""
function root end

"""
`$(FUNCTIONNAME)(problem)`

`$(FUNCTIONNAME)(problem, α)`

Recommended starting point of a test problem for methods that need one (eg quasi-Newton).
Usually taken from the literature that defines a problem, and should be “difficult”.

When used with a (positive real) argument `α`, the method should attempt to make it more
difficult (eg move away further from the root).

!!! note
    A default method is provided for the latter, problems just need to implement the
    single-argument version.
"""
function starting_point end

function starting_point(problem, α::Real)
    @argcheck α ≥ 0
    x0 = root(problem)
    x1 = starting_point(problem)
    @. x0 + (1 + α) * (x1 - x0)
end

"""
$(SIGNATURES)

Recommended lower bounds for box-constrained methods. Lower- and upper bounds are guaranteed
to contain the root. Coordinate-wise midpoints of bounds should not be near the root.

See also [`upper_bounds`](@ref).
"""
lower_bounds(problem) = fill(-100.0, domain_dimension(problem))

"""
$(SIGNATURES)

Recommended upper bounds for box-constrained methods. See [`lower_bounds`](@ref).
"""
upper_bounds(problem) = fill(50.0, domain_dimension(problem))

####
#### specific test problems
####

###
### Nocedal and Wright p 281
###

"Problem from Nocedal and Wright, p 281."
struct F_NWp281 end

domain_dimension(::F_NWp281) = 2

root(::F_NWp281) = [0, 1]

starting_point(::F_NWp281) = [-0.5, 1.4]

function (::F_NWp281)(x)
    x1, x2 = x
    [(x1 + 3) * (x2^3 - 7) + 18, sin(x2 * exp(x1) - 1)]
end

###
### Rosenbrock
###

"Rosenbrock function. (1) from Moré et al (1981)."
struct Rosenbrock end

domain_dimension(::Rosenbrock) = 2

root(::Rosenbrock) = [1, 1]

starting_point(::Rosenbrock) = [-1.2, 1]

function (::Rosenbrock)(x)
    x1, x2 = x
    [10 * (x2 - abs2(x1)), 1 - x1]
end

###
### Powell singular function
###

"Powell singular function. (13) from Moré et al (1981)."
struct PowellSingular end

domain_dimension(::PowellSingular) = 4

root(::PowellSingular) = zeros(4)

starting_point(::PowellSingular) = [3, -1, 0, 1]

function (::PowellSingular)(x)
    x1, x2, x3, x4 = x
    [x1 + 10 * x2, √5 * (x3 - x4), abs2(x2 - 2 * x3), √10 * abs2(x1 - x4)]
end

###
### Powell badly scaled function
###

"Powell's badly scaled function. (3) from Moré et al (1981)."
struct PowellBadlyScaled end

domain_dimension(::PowellBadlyScaled) = 2

root(::PowellBadlyScaled) = [1.0981593296999222e-5, 9.106146739865656]

starting_point(::PowellBadlyScaled) = [0, 1]

function (::PowellBadlyScaled)(x)
    x1, x2 = x
    [1e4 * x1 * x2 - 1, exp(-x1) + exp(-x2) - 1.0001]
end

###
### Helical valley function
###

"Helical valley function. (7) from Moré et al (1981)."
struct HelicalValley end

domain_dimension(::HelicalValley) = 3

root(::HelicalValley) = [1, 0, 0]

starting_point(::HelicalValley) = [-1, 0, 0]

function (::HelicalValley)(x)
    x1, x2, x3 = x
    θ = 1/(2π) * atan(x2 / x1) + ifelse(x1 < 0, 0.5, 0)
    [10*(x3 - 10 * θ), 10 * (hypot(x1, x2) - 1), x3]
end

###
### Beale function
###

"Beale function. (5) from Moré et al (1981)."
struct Beale end

domain_dimension(::Beale) = 2

range_dimension(::Beale) = 3

root(::Beale) = [3, 0.5]

starting_point(::Beale) = [1, 1]

function (::Beale)(x)
    [1.5, 2.25, 2.625] .- x[1] .* (1 .- x[2] .^ (1:3))
end

end # module
