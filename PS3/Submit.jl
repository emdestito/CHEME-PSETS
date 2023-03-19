include("Include.jl")

number_of_steps = trunc(Int, 20/0.1)

case_1 = build(MyChemicalDecayModel, κ = 1.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)
case_2 = build(MyChemicalDecayModel, κ = 10.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)
case_3 = build(MyChemicalDecayModel, κ = 100.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)

z = zeros(Float64, number_of_steps)

#For case_1
jacobi_1 = solve(JacobiIterationSolver(), case_1, z)
gauss_1 = solve(GaussSeidelIterationSolver(), case_1, z)

#For case_2
jacobi_2 = solve(JacobiIterationSolver(), case_2, z)
gauss_2 = solve(GaussSeidelIterationSolver(), case_2, z)

#For case_3
jacobi_3 = solve(JacobiIterationSolver(), case_3, z)
gauss_3 = solve(GaussSeidelIterationSolver(), case_3, z)

#Calculate the determinants
det_case_1 = det(case_1.A)
det_case_2 = det(case_2.A)
det_case_3 = det(case_3.A)


#Calculate inverses
inv_1 = inv(case_1.A)
inv_2 = inv(case_2.A)
inv_3 = inv(case_3.A)

#Multiply inverses of each case
prod_inv_1 = inv_1*case_1.b
prod_inv_2 = inv_2*case_2.b
prod_inv_3 = inv_3*case_3.b

#Calculate the errors
j_error_1 = norm(jacobi_1 - prod_inv_1)
j_error_2 = norm(jacobi_2 - prod_inv_2)
j_error_3 = norm(jacobi_3 - prod_inv_3)

g_error_1 = norm(gauss_1 - prod_inv_1)
g_error_2 = norm(gauss_2 - prod_inv_2)
g_error_3 = norm(gauss_3 - prod_inv_3)

#Test if each case is diagonally dominant
function diagonally_dominant(A::Matrix)
    m, n = size(A)
    for i = 1:m
        if abs(A[i,i]) ≤ sum(abs.(A[i,1:i-1])) + sum(abs.(A[i,i+1:n]))
            return false
        end
    end
    return true
end

#Case 1
if diagonally_dominant(case_1.A)
    println("Case_1 is diagonally dominant")
else
    println("Case_1 is not diagonally dominant")
end

#Case 2
if diagonally_dominant(case_2.A)
    println("Case_2 is diagonally dominant")
else
    println("Case_2 is not diagonally dominant")
end

#Case 3
if diagonally_dominant(case_3.A)
    println("Case_3 is diagonally dominant")
else
    println("Case_3 is not diagonally dominant")
end
