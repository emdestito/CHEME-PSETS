abstract type AbstractChemicalCompoundModel end

"""
    MyChemicalCompoundModel

Holds data for the chemical compound records
"""
mutable struct MyChemicalCompoundModel <: AbstractChemicalCompoundModel

    # data -
    name::String
    formula::String
    composition::Dict{Char,Int}

    # constuctor
    MyChemicalCompoundModel() = new()
end