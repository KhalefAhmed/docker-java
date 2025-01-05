# Docker Java Performance Benchmark

Ce projet compare les performances de démarrage de différentes images Docker Java.

# Comparaison des images Docker

| Image  | Taille     | Temps de démarrage |
|--------|------------|---------------------|
| graal  | 13.3784 MB | 134 ms              |
| alpine | 55.1744 MB | 618 ms              |
| module | 76.3429 MB | 561 ms              |
| plain  | 502.007 MB | 531 ms              |

## Analyse

- **Image la plus légère :** graal (13.3784 MB)
- **Démarrage le plus rapide :** graal (134 ms)
- **Image la plus lourde :** plain (502.007 MB)

L'image graal offre les meilleures performances en termes de taille et de temps de démarrage, tandis que l'image plain est la plus volumineuse mais offre un temps de démarrage moyen.

## Méthodologie

Les tests ont été effectués en utilisant un script personnalisé qui mesure le temps nécessaire pour démarrer chaque conteneur et exécuter une commande simple. La taille de l'image est obtenue directement à partir des métadonnées de l'image Docker.

Pour plus de détails sur la méthodologie ou pour reproduire ces tests, veuillez consulter le script `benchmark.sh`