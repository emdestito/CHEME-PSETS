include("Include.jl")

number_of_steps = trunc(Int, 20/0.1)

case_1 = build(MyChemicalDecayModel, κ = 1.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)
case_2 = build(MyChemicalDecayModel, κ = 10.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)
case_3 = build(MyChemicalDecayModel, κ = 100.0, h = 0.1, N = number_of_steps, Cₒ = 10.0)



zₒ = zeros(Float64, number_of_steps)

#For case_1
jacobi_1 = solve(JacobiIterationSolver(), case_1, zₒ)
gauss_1 = solve(GaussSeidelIterationSolver(), case_1, zₒ)


#For case_2
jacobi_2 = solve(JacobiIterationSolver(), case_2, zₒ)
gauss_2 = solve(GaussSeidelIterationSolver(), case_2, zₒ)

#For case_3
jacobi_3 = solve(JacobiIterationSolver(), case_3, zₒ)
gauss_3 = solve(GaussSeidelIterationSolver(), case_3, zₒ)


inv_1 = inv(case_1.A)
inv_2 = inv(case_2.A)
inv_3 = inv(case_3.A)

#Multiply inverses of each case
prod_inv_1 = inv_1*case_1.b
prod_inv_2 = inv_2*case_2.b
prod_inv_3 = inv_3*case_3.b

#Calculate the determinants
det_case_1 = det(case_1.A)
det_case_2 = det(case_2.A)
det_case_3 = det(case_3.A)

#Calculate the errors
j_error_1 = norm(jacobi_1 - prod_inv_1)
j_error_2 = norm(jacobi_2 - prod_inv_2)
j_error_3 = norm(jacobi_3 - prod_inv_3)

g_error_1 = norm(gauss_1 - prod_inv_1)
g_error_2 = norm(gauss_2 - prod_inv_2)
g_error_3 = norm(gauss_3 - prod_inv_3)


#Check Diagonally Dominant for each case
println("case_1: ", all(sum(abs.(case_1.A),dims=2) .<= 2abs.(diag(case_1.A))))
println("case_2: ", all(sum(abs.(case_2.A),dims=2) .<= 2abs.(diag(case_2.A))))
println("case_3: ", all(sum(abs.(case_3.A),dims=2) .<= 2abs.(diag(case_3.A))))