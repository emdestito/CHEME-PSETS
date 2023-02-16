
"""
    encrypt(plaintext::String) -> Dict{Int64,String}

    Encrypt function turns a string of plaintext message into a dictionary of Int64 matched with strings of DNA message in all uppercase.

    The function counts each character in the plaintext to number to keep them in the same position. 
    This matches the encrypted string for each character in their respective positions found in the keydict.
    The function generates the encrypted message using the build function 'DNAEncryptionKey' found in the "Factory.jl" file.
    
"""
function encrypt(plaintext::String)::Dict{Int64,String}
    # initialize -
    message = Dict{Int64,String}()
    counter = 0;

    # build encryptionkey -
    encryption_model = build(DNAEncryptionKey);
    encryptionkey = encryption_model.encryptionkey;

    for c ∈ uppercase(plaintext)

         # encrypt -
        message[counter] = encryptionkey[c]

        # update the counter -
        counter = counter + 1
    end

    # return -
    return message
end


"""
    decrypt(encrypteddata::Dict{Int64,String}) -> String

    Decrypt function turns a dictionary of Int64 matched with strings of DNA message into a string of plaintext message in all uppercase.
        The function inverses the dictionary to map the strings of DNA messgae to their corresponding character in the keydict.
        The function generates the decrypted plaintext message using the build function 'DNAEncryptionKey' found in the "Factory.jl" file.

"""
function decrypt(encrypteddata::Dict{Int64,String})::String

   # initialize -
   number_of_chars = length(encrypteddata)
   inverse_encryptionkey_dict = Dict{String, Char}()
   plaintext = Vector{Char}()

   # build encryptionkey -
   encryption_model = build(DNAEncryptionKey);
   encryptionkey = encryption_model.encryptionkey;

   # build the inverse_key -
   for (key, value) ∈ encryptionkey
       inverse_encryptionkey_dict[value] = key
   end

   for i ∈ 0:(number_of_chars - 1)
       
       codon = encrypteddata[i]
       value = inverse_encryptionkey_dict[codon]
       push!(plaintext, value)
   end

   # return -
   return String(plaintext)
end