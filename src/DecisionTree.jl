using CSV
using DataFrames
using DecisionTree
using Statistics  # pour la fonction mean()

df = CSV.read("data/bc_data.csv", DataFrame)
fold_df = CSV.read("data/folds.csv", DataFrame)

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
# Liste des scores de réussite des 5 plis 
accuracy = Float64[]
# Respectivement liste des prédictions et des vrais diagnostiques 
all_y_test = String[]
all_y_pred = String[]



                                # DECOUPAGE EN PLI
for k in 1:5 
    train_idx = findall(folds .!= k) # Lignes des patientes du groupe d'entraînement (tous les autres plis sauf k)
    test_idx  = findall(folds .== k) # Lignes des patientes du groupe test (celles du pli k)

# Séparation train / test
X_train, y_train = X[train_idx, :], y[train_idx]
X_test, y_test   = X[test_idx, :], y[test_idx]

                                # ENTRAINEMENT DE L'ARBRE

# build_tree(y_train, X_train, nbr de variables (0 = toutes), profondeur max)

model = build_tree(y_train, X_train, 0, 3)  
# model = build_tree(y_train, X_train, 0, 2) 
# model = build_tree(y_train, X_train, 0, 4)  


# 4. Affichage de l'arbre
println("RÈGLES DE DÉCISION DE L'ARBRE ")
print_tree(model)


###### PARTIE TEST ######

# 5. Prédiction sur le jeu de test
y_pred = apply_tree(model, X_test)

# 6. Évaluation globale
acc = mean(y_pred .== y_test)
println("Taux de bonnes prédictions (Accuracy) : ", round(acc * 100, digits=2), " %")

# 7. Matrice de confusion
# Permet de repérer directement les faux négatifs
cm = confusion_matrix(y_test, y_pred)
println("\nMatrice de confusion :")
println(cm)

