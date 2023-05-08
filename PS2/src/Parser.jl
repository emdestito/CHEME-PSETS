"""
    _recursive_compound_parser(q::Queue, atoms::Queue{Char}, numbers::Queue{Char}, result::Dict{Char,Int64})

This function recursively processes each character in the Queue `q`, which holds the compound molecular formula.
The composition for each compound is put into the `result` dictionary where the keys are elements, the values are the number of elements of that type in the compound.
"""
function _recursive_compound_parser(q::Queue, atoms::Queue{Char}, numbers::Queue{Char}, result::Dict{Char,Int64})
    
    if (isempty(q) == true) # base case -
        
        # This is the base case: we have processed all the characters in q

        # If atoms and numbers have some stuff in them, then we have one final atom => count pair
        if (isempty(atoms) == false && isempty(numbers) == false)
            word = join(numbers)
            if (isempty(word) == false)
               key = dequeue!(atoms)
               result[key] = parse(Int64,word)
            end
        elseif (isempty(atoms) == false && isempty(numbers) == true) # this case handles the dangling element case
            key = dequeue!(atoms)
            result[key] = 1
        end
        
        return nothing
    else
        
        # Recursive case: check the next char -
        next_char = dequeue!(q)
        if (isnumeric(next_char) == false)

            # if we get here, then we have hit a letter, this means we should store that letter in the atoms queue
            
            # Check if the next character is an uppercase letter and the current atom queue is not empty
            if (isuppercase(next_char) == true && isempty(atoms) == false)
                # Add the current atom queue as a single atom to the result dictionary with a count of 1
                key = dequeue!(atoms)
                # If we have just one atom of this type, then the corresponding number is 1
                if (isempty(numbers))
                    result[key] = 1
                else
                    result[key] = parse(Int64, join(numbers))
                    # Empty out the numbers queue, because we may need it again
                    empty!(numbers)
                end
            end
            
            enqueue!(atoms, next_char)
        else

            # if we get here, next_char is a number, so enqueue next_char into the numbers queue
            # Why? we are collecting all the next_char's that are numbers until we hit an element or hit the base case
            # When we hit an element the characters in the numbers queue can be joined to make a number
            enqueue!(numbers, next_char)
        end

        # Process the next character in the queue
        _recursive_compound_parser(q, atoms, numbers, result)
    end
end



"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel}) -> Dict{String, MyChemicalCompoundModel}

This function processes each compound in the `compounds` dictionary by calling the `_recursive_compound_parser` function.
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})

    # process each compound
    for (_, model) ∈ compounds
    
        # initialize -
        numbers = Queue{Char}()
        atoms = Queue{Char}()
        q = Queue{Char}()
        result = Dict{Char,Int64}()

        # run this for a single compound -
        compound_string = model.formula

        # build the Queue q that we are going to parse -
        character_arr = collect(compound_string)
        for c ∈ character_arr
            enqueue!(q, c);
        end

        # recursive descent -
        _recursive_compound_parser(q, atoms, numbers, result);

        # update the model -
        model.composition = result;
    end

    # return the updated dictionary
    return compounds
end


