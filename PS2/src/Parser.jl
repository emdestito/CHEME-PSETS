# This function takes in a queue of characters, an array of characters and an array of numbers as arguments
function _recursive_compound_parser(q::Queue{Char}, characters::Array{Char,1}, numbers::Array{Int,1})

    # Check if queue is empty
    if (isempty(q) == true)
        return nothing

    
    # If queue is not empty
    else
        # Get the next character from the queue
        next_char = dequeue!(q)
        # Check if the character is numeric or not
        if (isnumeric(next_char) == false)
            # If the character is not numeric, add it to the characters array
            push!(characters,next_char)
            #if next_char was the last letter, we include a 1 as its corresponding number and end code
            if (isempty(q) == true)
               push!(numbers,1)
            end
        else
            # If the character is numeric, check if the queue is empty
            if (isempty(q) == true)
                # If the queue is empty, parse the character as an integer and add it to the numbers array
                push!(numbers, parse(Int,next_char))
            else
                # If the queue is not empty, get the next character from the queue
                next_char2 = dequeue!(q)
                # Check if the second character is numeric or not
                if (isnumeric(next_char2) == true)
                    # If the second character is also numeric, concatenate both characters as a string and parse it as an integer,
                    # then add it to the numbers array
                    n = string(next_char,next_char2)
                    N = parse(Int, n)
                    push!(numbers,N)
                else
                    # If the second character is not numeric, parse the first character as an integer and add it to the numbers array
                    # Then add the second character to the characters array
                    push!(numbers,parse(Int,next_char))
                    push!(characters,next_char2)
                end
            end
        end
    end
    # Recursively call the function with the updated queue, characters and numbers arrays
    _recursive_compound_parser(q, characters, numbers)
end 


"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}

    This function takes in a dictionary of MyChemicalCompoundModel objects as an argument and parses their formulas to obtain
    their compositions. It uses the _recursive_compound_parser function to parse each formula.

    Args:
    - compounds: A dictionary of MyChemicalCompoundModel objects with the compound name as the key and the model as the value.

    Returns:
    - A dictionary of MyChemicalCompoundModel objects with the compound name as the key and the updated model as the value.
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}
   
    # Loop through each compound in the dictionary
    for (name, model) ∈ compounds
        # Create a dictionary to store the composition of the compound
        composition = Dict{Char,Int}()
        # Create a queue, and arrays to store characters and numbers
        q = Queue{Char}()
        characters = Array{Char,1}()
        numbers = Array{Int,1}()
      
        # Convert the formula string to an array of characters
        character_arr = collect(model.formula)
        
        # Enqueue each character into the queue
        for c ∈ character_arr
            enqueue!(q, c)
        end

        # Call the recursive parser function to obtain the characters and numbers arrays
        _recursive_compound_parser(q, characters, numbers)

        # Add the characters and their corresponding numbers to the composition dictionary
        counter = 1
        for X ∈ characters
            composition[X] = numbers[counter]
            counter += 1
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

  


