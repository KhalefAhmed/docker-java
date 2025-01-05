# Docker Java Performance Benchmark

Ce projet compare les performances de démarrage de différentes images Docker Java.

## Résultats

Voici les résultats de nos tests de performance :

| Image  | Taille    | Temps de démarrage |
|--------|-----------|---------------------|
| plain  | 502.01MB  | 538 ms              |
| module | 76.34MB   | 514 ms              |
| graal  | 18.69MB   | 523 ms              |

## Analyse

- L'image **plain** est la plus grande en taille (502.01MB) et a le temps de démarrage le plus long (538 ms).
- L'image **module** offre une réduction significative de la taille (76.34MB) tout en ayant le temps de démarrage le plus rapide (514 ms).
- L'image **graal** est de loin la plus petite (18.69MB), avec un temps de démarrage intermédiaire (523 ms).

Ces résultats montrent que la modularisation et l'utilisation de GraalVM peuvent significativement réduire la taille des images Docker tout en maintenant, voire en améliorant, les performances de démarrage.

## Méthodologie

Les tests ont été effectués en utilisant un script personnalisé qui mesure le temps nécessaire pour démarrer chaque conteneur et exécuter une commande simple. La taille de l'image est obtenue directement à partir des métadonnées de l'image Docker.

Pour plus de détails sur la méthodologie ou pour reproduire ces tests, veuillez consulter le script `benchmark.sh` dans