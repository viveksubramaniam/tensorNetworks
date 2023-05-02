using ITensors

let
  N = 2
  U = 0.5 
  t = 1
  # C = op("C")
  sites = siteinds("Fermion",N)

  os = OpSum()

  for i = 1:N
    os += U, "Cdag", i, "C", i, "Cdag", i, "C", i
  
  end

  for i=1:N-1

    os += t, "C", i, "Cdag", i+1
    os += t, "C", i+1, "Cdag", i

  end

  H = MPO(os,sites)

  psi0 = randomMPS(sites,10)

  nsweeps = 100
  maxdim = [10,20,100,100,200]
  cutoff = [1E-10]

  energy, psi = @time dmrg(H,psi0; nsweeps, maxdim, cutoff)

  return
end