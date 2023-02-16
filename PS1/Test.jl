#include the code needed
include("Include.jl")

#Test text"
plaintext = "Charizard is my favorite Pokemon."

#run functions
encrypt_message = encrypt(plaintext)
println(encrypt_message)

plaintext_message = decrypt(encrypt(plaintext))
println(plaintext_message)