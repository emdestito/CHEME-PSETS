
function _recursive_compound_parser(q::Queue{Char}, characters::Array{Char,1}, numbers::Array{Int,1})

     
    if (isempty(q) == true)
        return nothing
    
    
        else
            next_char = dequeue!(q)
            if (isnumeric(next_char) == false)
                push!(characters,next_char)
        
            else
                 if (isempty(q) == true)
                    push!(numbers, parse(Int,next_char))
                 else
                    next_char2 = dequeue!(q)
                       
                    if (isnumeric(next_char2) == true)
                        n = string(next_char,next_char2)
                        N = parse(Int, n)
                        push!(numbers,N)
                    else
                        push!(numbers,parse(Int,next_char))
                        push!(characters,next_char2)
                    end
                end
    
            
            end
        
        end
    
    
    
        _recursive_compound_parser(q, characters, numbers)
    
    end  
    
        
"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}

TODO: Describe what this function does, the args and what we expect it to return 
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}
   
    for (name, model) ∈ compounds
        composition = Dict{Char,Int}()
        q = Queue{Char}()
        characters = Array{Char,1}()
        numbers = Array{Int,1}()
      
    
        character_arr = collect(model.formula)
    #for (name, model) ∈ compounds  
        for c ∈ character_arr
            enqueue!(q, c)
        end


        
        _recursive_compound_parser(q, characters, numbers)

        counter = 1
         for X ∈ characters
            composition[X] = numbers[counter]
            counter = counter + 1
        end

        model.composition = composition
    end

    return compounds
end


    
    # TODO: Implement a function that computes a composition dictionary of type Dict{Char,Int} for each of the compounds in the compounds dictionary
    #
    # Composition dictionary:
    # The composition dictionary will hold the elements of the compounds as Chars 
    # The number of each element will be the value held in the composition dictionary

    # the parsering logic should be written in the _recursive_compound_parser function.

    # This function should return the updated instances of the MyChemicalCompoundModel types holding the composition dictionary in the 
    # the composition field.

  

