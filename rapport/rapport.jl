try; import KaimonSlate; catch; error("This is a Kaimon Slate notebook — running it as plain Julia needs the KaimonSlate runtime in this environment. Add it with `import Pkg; Pkg.add(\"KaimonSlate\")`, or open it in Kaimon Slate."); end; KaimonSlate.standalone!(@__MODULE__; dir=@__DIR__)

#%% md id=5000ca
@md"""
# Arbres de décision et forêts aléatoires appliqués à la santé -- Julia

## Contexte

Les arbres de décision et les forêts aléatoires (Random Forest) sont des
méthodes d'apprentissage supervisé très utilisées en santé. Un arbre de décision
prédit en posant une série de questions sur les données, étape par étape. Une
forêt aléatoire combine plusieurs arbres entraînés sur des échantillons
différents (bootstrap) et agrège leurs prédictions, ce qui la rend en général
plus robuste.

## Problématique

Dans quelle mesure les arbres de décision et les forêts aléatoires
permettent-ils d'identifier les facteurs associés au statut diabétique et de
prédire le risque de cancer du sein à partir de caractéristiques individuelles
de santé ?


## Données

Nous utilisons le jeu de données Breast Cancer Coimbra (UCI Machine Learning
Repository), qui contient des mesures cliniques : âge, IMC, glucose, insuline,
indice HOMA, leptine, adiponectine, résistine et MCP-1. Pour que les résultats
de R et de Julia soient comparables, les deux parties partent des mêmes
fichiers :

- coimbra_clean.csv : classification (personne saine ou patiente) ;
- coimbra_reg.csv : régression, avec comme variable à prédire logLeptin, le
  logarithme du taux de leptine ;
- folds.csv : découpage en 5 plis pour la validation croisée.

## Démarche

1. Arbre de décision : approche classification, puis régression.
2. Forêt aléatoire : approche classification, puis régression.
3. Comparaison de la fiabilité des résultats entre les deux méthodes et entre
   les deux langages.

La validation croisée en 5 plis utilise le même découpage (folds.csv) dans les
deux langages, car R et Julia ne génèrent pas les mêmes nombres aléatoires.
Pour la classification, nous mesurons l'accuracy, la sensibilité, la
spécificité et l'AUC (la classe positive étant « cancer »). Pour la
régression, nous mesurons le RMSE, le MAE et le R², en moyenne sur les 5 plis.
"""

#%% md id=3e2136
@md"""
# Journal de bord et évolution du projet


## Arbres de décision





## Forêt aléatoire






"""

# ╔═╡ Slate.config · per-notebook settings (Settings panel)
#   docid = 3203f0f8-1b61-4daa-89cb-baafda91c00b
# ╚═╡
