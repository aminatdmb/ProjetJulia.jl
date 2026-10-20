using Pkg; 
Pkg.add("GLM"); 
using CSV
using  DataFrames
using GLM

# 1. Chargement des données
df_reg   = CSV.read(normpath(joinpath(@__DIR__, "..", "data", "coimbra_reg.csv")), DataFrame)
folds_df = CSV.read(normpath(joinpath(@__DIR__, "..", "data", "folds.csv")), DataFrame)

# Vérification de la database 
describe(df_reg)

# Récupération de la colonne des plis
folds = folds_df.fold

#Liste du taux d'erreurs par pli 
taux_erreur_pli = []

for k in 1:5 
    lignes_train = findall(folds .!= k) # Lignes des patientes du groupe d'entraînement (tous les autres plis sauf k)
    lignes_test  = findall(folds .== k) # Lignes des patientes du groupe test (celles du pli k)

# Découpage des données
    train_data = df_reg[lignes_train, :]
    test_data  = df_reg[lignes_test, :]



# On cherche à prédire logLeptin en fonction de l'Âge, de l'IMC, du Glucose...
modele = lm(@formula(logLeptin ~ Age + BMI + Glucose + Insulin + Adiponectin + Resistin + MCP1), train_data)

predictions = predict(modele, test_data)

vraies_valeurs = test_data.logLeptin
taux_erreur_pli_k = sqrt(mean((vraies_valeurs .- predictions).^2)) 

push!(rmse_par_pli, rmse_k)
println("Le taux d'erreur du pli $k est  : ", round(taux_erreur_pli_k, digits=4))

end

println("Taux d'erreur moyen : "")






