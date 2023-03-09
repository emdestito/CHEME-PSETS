
function _recursive_compound_parser(q::Queue{Char}, characters::Array{Char,1}, numbers::Array{Int,1})

   next_char = dequeue!(q)
    if (isempty(q) == true)
        return nothing

    else
        next_char = dequeqe!(q)
        if (isnumeric(next_char) == false)
            push!(characters, next_char)
        else
            if (next_char = last(character_arr, 1) == true)
                push!(characters, next_char)
                map(next_char -> 1)

            end
        
            if (isnumeric(next_char) == true)
                push!(numbers, next_char)
            end
        end
        _recursive_compound_parser(q, characters, numbers)
    end
end

"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel}) -> Dict{String, MyChemicalCompoundModel}

TODO: Describe what this function does, the args and what we expect it to return 
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}
   for (name, formula) ∈ compounds
    composition = Dict{Char,Int}()
    q = Queue{Char}()
    characters = Array{Char,1}()
    numbers = Array{Int,1}()
    character_arr = collect(compounds.formula)
    counter = 0
        for c ∈ character_arr
            enqueue!(q, c)
        end


        _recursive_compound_parser(q, characters, numbers)

        for x ∈ characters
            composition[x] = numbers[counter]
            counter = counter + 1
        end

        formula.composition = composition
    end

    return composition
end





    
    # TODO: Implement a function that computes a composition dictionary of type Dict{Char,Int} for each of the compounds in the compounds dictionary
    #
    # Composition dictionary:
    # The composition dictionary will hold the elements of the compounds as Chars 
    # The number of each element will be the value held in the composition dictionary

    # the parsering logic should be written in the _recursive_compound_parser function.

    # This function should return the updated instances of the MyChemicalCompoundModel types holding the composition dictionary in the 
    # the composition field.

  

