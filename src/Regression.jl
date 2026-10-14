using Pkg; 
Pkg.add("GLM"); 
using CSV
using  DataFrames
using GLM

df = CSV.read("data/coimbra_reg.csv", DataFrame)

# Vérification de la database 

#first(data, 5)
describe(df) # Vérification des données manquantes 
size(df)
names(df)