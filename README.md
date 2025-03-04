# Inception of Things (IoT)

![Work in Progress](https://img.shields.io/badge/Work%20In%20Progress-orange) ⚠️ ***This repository is being edited and so is not finished yet.*** ⚠️

Description :
Développement d’un environnement Kubernetes minimaliste en utilisant K3s et K3d, avec une gestion simplifiée des clusters via Vagrant et une intégration du déploiement CI/CD via Argo CD. Ce projet inclut la gestion d’applications déployées sur Kubernetes et l'automatisation des processus à travers GitHub et Argo CD.

Compétences et technologies utilisées :

    Langages et technologies : Kubernetes (K3s, K3d), Docker, Vagrant, Argo CD, GitHub, GitLab (optionnel)
    Outils : Vagrant, K3d, Argo CD, GitHub Actions, Docker Hub
    Méthodologie : CI/CD, gestion de clusters Kubernetes, automatisation des déploiements

Responsabilités et Réalisations :

    Création d'un environnement Kubernetes avec K3s :
        Mise en place d’un environnement Kubernetes léger avec K3s en mode serveur et agent.
        Création de deux machines Vagrant pour gérer les clusters et déployer des applications.
        Passage à K3d pour gérer un cluster Kubernetes local via Docker, simplifiant ainsi la gestion des ressources et la configuration.

    Déploiement d'applications sur Kubernetes :
        Déploiement de trois applications web simples sur Kubernetes, testées avec un Ingress Controller pour gérer les requêtes HTTP entrantes.
        Utilisation d'un fichier YAML pour la configuration des déploiements et services Kubernetes.
        Mise en place de réplicas pour une application afin de tester la haute disponibilité et la gestion des ressources.

    Automatisation des déploiements avec Argo CD :
        Installation et configuration d’Argo CD pour automatiser le déploiement des applications.
        Connexion de Argo CD à un dépôt GitHub pour un déploiement continu (CI/CD) et gestion des versions des applications.

    Tests et validation :
        Tests du bon fonctionnement des applications déployées sur le cluster Kubernetes à l’aide de différents HOST headers pour valider la configuration des services.
        Validation de la configuration des Ingress Controllers et de la communication entre les services dans le cluster.

    Optimisation de la gestion des ressources :
        Utilisation efficace de K3s et K3d pour minimiser la consommation des ressources système, tout en permettant des déploiements rapides et une gestion fluide des applications.
        Mise en place de mécanismes de gestion des erreurs dans les déploiements via Argo CD pour assurer la stabilité du processus CI/CD.

    Bonus : Intégration de GitLab pour CI/CD :
        Mise en place d’une instance GitLab locale et intégration avec Argo CD pour un pipeline complet de gestion des déploiements CI/CD, permettant des mises à jour automatiques à partir de GitLab.

Résultats :

    Serveur Kubernetes fonctionnel : Déploiement réussi d’un environnement Kubernetes avec K3s et K3d pour exécuter plusieurs applications web sur un cluster local.
    Automatisation des déploiements CI/CD : Mise en place d’un pipeline CI/CD complet avec Argo CD et GitHub pour un déploiement rapide et sécurisé des applications.
    Optimisation des ressources : Configuration et gestion efficaces des ressources systèmes avec K3d et K3s, permettant un fonctionnement stable et réactif du cluster Kubernetes.
    Scalabilité : Grâce aux réplicas et à l'usage de K3s, le système gère plusieurs applications et utilisateurs simultanés sans impact majeur sur les performances.
