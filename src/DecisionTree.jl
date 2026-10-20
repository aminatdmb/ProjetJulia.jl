using CSV
using DataFrames
using DecisionTree
using Statistics  # pour la fonction mean()

df = CSV.read(normpath(joinpath(@__DIR__, "..", "data", "coimbra_clean.csv")), DataFrame)
folds_df = CSV.read(normpath(joinpath(@__DIR__, "..", "data", "folds.csv")), DataFrame)

# Vérification de la database 
#first(df, 5)
describe(df) # Vérification des données manquantes 
size(df)
names(df)

X = Matrix(df[:, 1:9]) # matrice des variables
y = Vector(df[:, :Classification]) # vecteur contenant le diagnostic réel de chaque patiente ( Classification : sain/cancer )
 
# Récupération du vecteur de plis (1 à 5)
folds = folds_df.fold 


# Validation des 5 plis 
# Initialisation liste des scores de réussite des 5 plis 
pred_accuracy = Float64[]
# Respectivement liste des prédictions et des vrais diagnostiques 
all_y_test = []
all_y_pred = []



                                # DECOUPAGE EN PLI
for k in 1:5 
    lignes_train = findall(folds .!= k) # Lignes des patientes du groupe d'entraînement (tous les autres plis sauf k)
    lignes_test  = findall(folds .== k) # Lignes des patientes du groupe test (celles du pli k)

# Séparation train / test
X_train, y_train = X[lignes_train, :], y[lignes_train]
X_test, y_test   = X[lignes_test, :], y[lignes_test]

                                # ENTRAINEMENT DE L'ARBRE

# build_tree(y_train, X_train, nbr de variables (0 = toutes), profondeur max)

arbre = build_tree(y_train, X_train, 0, 3)  
# arbre = build_tree(y_train, X_train, 0, 2) 
# arbre = build_tree(y_train, X_train, 0, 4)  


# 4. Affichage de l'arbre
println("RÈGLES DE DÉCISION DE L'ARBRE ")
print_tree(arbre)


###### PARTIE TEST ######

# 5. Prédiction sur le jeu de test
y_pred = apply_tree(arbre, X_test)

# 6. Évaluation (comparaison entre les réponses de l'arbre et les résultats réels)
acc_k = mean(y_pred .== y_test)

# On stocke le niveau d'accuracy des prédictions de chaque pli dans la liste pred_accuracy
push!(pred_accuracy, acc_k)
println("Le taux d'exactitude du pli $k est de ", round(acc_k * 100, digits=2), " %")

# Pour la matrice de confusion 
append!(all_y_test, y_test)
append!(all_y_pred, y_pred)

end


println("Le taux d'exactitude moyen est de", round(mean(pred_accuracy) * 100, digits=2), " % 
(± ", round(std(pred_accuracy) * 100, digits=2), " %)") #ecart-type


# 7. Matrice de confusion (repérer les faux négatifs et postifs)
cm = DecisionTree.confusion_matrix(all_y_test, all_y_pred)
println("Matrice de confusion :")
println(cm)

