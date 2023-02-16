#set up paths and include codes needed to run encrypt and decrypt functions

const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src")


#load code
include(joinpath(_PATH_TO_SRC, "Types.jl"))
include(joinpath(_PATH_TO_SRC, "Factory.jl"))
include(joinpath(_PATH_TO_SRC, "CHEME-1800-ProblemSet-1-Lib.jl"))
