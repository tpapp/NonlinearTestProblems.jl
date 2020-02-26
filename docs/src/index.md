# NonlinearTestProblems.jl

This package is a collection ``ℝⁿ → ℝᵐ`` functions commonly used for testing nonlinear solvers and optimizers.

It just defines a very basic common API described below, and should be wrapped for practical use. In particular,

1. Derivatives are not provided. It is recommended that you use one of the automatic differentiation packages from the Julia ecosystem, eg [ForwardDiff.jl](https://github.com/JuliaDiff/ForwardDiff.jl) or [Zygote.jl](https://github.com/FluxML/Zygote.jl).

2. If you need an objective for an *optimization* problem, just use some transformation like `sum(abs2, y)`.

3. If your API expects functions in some particular form, just wrap accordingly.

## API

```@docs
domain_dimension
range_dimension
root
starting_point
lower_bounds
upper_bounds
```

## Contributing

Contributions are welcome in the form of pull requests.

1. Try to follow the coding style of the package, which mostly aims to conform to [the manual](https://docs.julialang.org/en/v1/manual/style-guide/) and  [YASGuide](https://github.com/jrevels/YASGuide).

2. Look at existing implementations as examples.

3. Always cite sources (see the `CITATIONS.bib` in the source).

4. Feature requests and suggestions are welcome.

## Test problems

```@docs
F_NWp281
Rosenbrock
PowellSingular
PowellBadlyScaled
HelicalValley
```
