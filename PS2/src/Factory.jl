"""
    build(type::Type{MyChemicalCompoundModel}, name::String, formula::String)::MyChemicalCompoundModel

Factory method to build an instance of the MyChemicalCompoundModel type. MyChemicalCompoundModel is a model of the
information contained in the Compounds.data file
"""
function build(type::Type{MyChemicalCompoundModel}, name::String, formula::String)::MyChemicalCompoundModel

    # check: name, reactants and products correct?
    # in production, we'd check this. Assume these are ok now

    # initialize -
    model = MyChemicalCompoundModel(); # build an empty model 

    # add data to the model -
    model.name = name;
    model.formula = formula;

    # return -
    return model;
end