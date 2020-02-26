using Documenter, NonlinearTestProblems

makedocs(
    modules = [NonlinearTestProblems],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Tamas K. Papp",
    sitename = "NonlinearTestProblems.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/tpapp/NonlinearTestProblems.jl.git",
    push_preview = true
)
