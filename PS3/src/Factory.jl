"""
    _build_right_handside_vector(N::Int64, κ::Float64, h::Float64, Cₒ::Float64) -> Array{Float64,1}

Internal function that constructs the right-hand side vector for the chemical decay problem
"""
function _build_right_handside_vector(N::Int64, κ::Float64, h::Float64, Cₒ::Float64)::Array{Float64,1}
    x = zeros(N)
    #We relaized the for loop we prevously had here was making the solver run backwards (from 0 to 9).
    x[1] = Cₒ-(Cₒ*h*κ)
    

    return x
end


"""
    _build_system_matrix(N::Int64, κ::Float64, h::Float64) -> Array{Float64,2}

Internal function that constructs the system matrix for the chemical decay problem
"""
function _build_system_matrix(N::Int64, κ::Float64, h::Float64)::Array{Float64,2}
    A = zeros(N,N)

    A[1,1] = 1.0

    #Our elseif statment was making our solution become all zeros (we previously had elseif (i>j)).
    for i ∈ 2:N
        for j ∈ 2:N
            if (i == j)
                A[i,j] = 1
            
            elseif (i > 1)
                for j = i-1
                    A[i,j] = (κ*h - 1)
                end

            else
                A[i,j] = 0

            end
        end
    end
    

    return A

end



"""
    build(type::Type{MyChemicalDecayModel}; 
        κ::Float64 = 0.0, h::Float64 = 0.0, N::Int64 = 0, Cₒ::Float64 = 0.0) -> MyChemicalDecayModel

Build an instance of MyChemicalDecayModel and sets the value of the model parameters. 
Default model parameters are zero
"""
function build(type::Type{MyChemicalDecayModel}; 
    κ::Float64 = 0.0, h::Float64 = 0.0, N::Int64 = 0, Cₒ::Float64 = 0.0)::MyChemicalDecayModel

    # build an empty model -
    model = MyChemicalDecayModel()

    # set parameters on the model
    model.κ = κ
    model.h = h
    model.N = N
    model.Cₒ = Cₒ
    model.A = _build_system_matrix(N, κ, h)
    model.b = _build_right_handside_vector(N, κ, h, Cₒ)

    # return
    return model
end