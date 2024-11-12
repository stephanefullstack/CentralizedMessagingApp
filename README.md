Centralized Messaging App
Description
Centralized Messaging App est une application de messagerie en temps réel construite avec Ruby on Rails. Elle utilise RailsAdmin pour fournir une interface d'administration pour la gestion des utilisateurs et des conversations, et Action Cable pour la diffusion en temps réel des messages via WebSockets.

Ce projet vise à permettre aux utilisateurs de créer des conversations et d'envoyer des messages en temps réel, tout en offrant aux administrateurs des outils pour gérer les données utilisateurs et les conversations depuis une interface dédiée.

Fonctionnalités
Messagerie en temps réel : Les messages envoyés dans une conversation sont diffusés en temps réel à tous les participants.
Gestion des utilisateurs : Les administrateurs peuvent gérer les utilisateurs, les conversations et les messages via une interface d'administration.
Interface d'administration avec RailsAdmin : Accès aux données d'utilisateurs et de conversations avec une interface utilisateur intuitive.
Authentification par jeton : Utilisation de Devise et Devise JWT pour l'authentification basée sur les jetons.
API RESTful : Une API REST pour les conversations et les messages, accessible aux utilisateurs connectés via des requêtes authentifiées.
Prérequis
Assurez-vous d'avoir les éléments suivants installés sur votre machine :

Ruby (version 3.3.0)
Rails (version 7.1.5)
Node.js et Yarn
PostgreSQL (ou tout autre système de gestion de base de données compatible)
Installation
Suivez ces étapes pour installer et configurer le projet sur votre machine locale.

1. Cloner le dépôt
bash
Copier le code
git clone <URL_du_dépôt>
cd CentralizedMessagingApp
2. Installer les dépendances
Installez les gems du projet avec Bundler :

bash
Copier le code
bundle install
Installez les dépendances JavaScript avec Yarn :

bash
Copier le code
yarn install
3. Configuration de la base de données
Créez et configurez la base de données PostgreSQL :

Dupliquez le fichier .env.example en .env et configurez les variables d'environnement, notamment les informations de connexion à la base de données et les clés JWT.

Créez la base de données, effectuez les migrations et chargez les données de base :

bash
Copier le code
rails db:create
rails db:migrate
rails db:seed
4. Initialiser RailsAdmin
RailsAdmin fournit une interface d'administration puissante pour gérer les données de votre application.

Exécutez la commande suivante pour installer RailsAdmin :

bash
Copier le code
rails g rails_admin:install
Ajoutez les middlewares nécessaires dans config/application.rb :

ruby
Copier le code
config.middleware.use ActionDispatch::Flash
config.middleware.use Rack::MethodOverride
Créez également le fichier app/assets/config/manifest.js (si ce n’est pas déjà fait) pour inclure les assets :

javascript
Copier le code
//= link_tree ../images
//= link_directory ../javascripts .js
//= link_directory ../stylesheets .css
Ensuite, redémarrez le serveur pour appliquer les modifications.

5. Configurer Action Cable
Action Cable est utilisé pour diffuser des messages en temps réel. Assurez-vous que le serveur Action Cable est configuré correctement dans config/cable.yml et que config/environments/development.rb est configuré pour utiliser Action Cable localement.

Démarrage
Démarrez le serveur Rails :

bash
Copier le code
rails server
Ensuite, rendez-vous sur http://localhost:3000 pour accéder à l'application.

Pour accéder à l'interface d'administration de RailsAdmin, allez sur http://localhost:3000/admin. Vous devrez être authentifié en tant qu'administrateur pour accéder à cette section.

API Endpoints
Authentification
L'authentification est gérée par Devise avec JWT. Utilisez les endpoints suivants pour obtenir des jetons d'authentification.

Connexion : POST /api/v1/users/sign_in
Exemple de requête :
bash
Copier le code
curl -X POST http://localhost:3000/api/v1/users/sign_in \
  -H "Content-Type: application/json" \
  -d '{
        "user": {
          "email": "email@example.com",
          "password": "password123"
        }
      }'
Réponse : {"token": "<votre_token>"}
Conversations
Lister les conversations : GET /api/v1/conversations
Créer une conversation : POST /api/v1/conversations
Exemple de requête :
bash
Copier le code
curl -X POST http://localhost:3000/api/v1/conversations \
  -H "Authorization: Bearer <votre_token>" \
  -H "Content-Type: application/json" \
  -d '{"conversation": {"title": "New Conversation"}}'
Afficher une conversation spécifique : GET /api/v1/conversations/:id
Messages
Lister les messages dans une conversation : GET /api/v1/conversations/:conversation_id/messages
Envoyer un message : POST /api/v1/conversations/:conversation_id/messages
Exemple de requête :
bash
Copier le code
curl -X POST http://localhost:3000/api/v1/conversations/1/messages \
  -H "Authorization: Bearer <votre_token>" \
  -H "Content-Type: application/json" \
  -d '{"message": {"content": "Hello World!"}}'
Configuration de l’Interface d’Administration
RailsAdmin est monté sur /admin. Vous pouvez le configurer dans config/initializers/rails_admin.rb.
Pour limiter l'accès aux données sensibles, ajoutez des règles de permissions et de rôles. Vous pouvez utiliser une gem comme Pundit ou CanCanCan pour une gestion fine des accès.
Déploiement
Pour déployer en production, suivez les étapes suivantes :

Préparer les assets :

bash
Copier le code
RAILS_ENV=production rails assets:precompile
Migrations : Exécutez les migrations sur la base de données de production.

Configuration d'Action Cable : En production, configurez Action Cable pour utiliser un service comme Redis pour la gestion des connexions.

Dépannage
Problèmes de WebSocket : Si les messages ne se mettent pas à jour en temps réel, vérifiez la configuration d'Action Cable et la connexion WebSocket dans la console.
Problèmes de configuration Sprockets : Assurez-vous que app/assets/config/manifest.js est correctement configuré et que les répertoires requis existent.
Erreur d'installation RailsAdmin : Si vous rencontrez des erreurs lors de l'installation de RailsAdmin, assurez-vous que toutes les dépendances sont à jour et que config/initializers/rails_admin.rb est correctement configuré.
Contribution
Les contributions sont les bienvenues. Pour contribuer :

Forkez ce dépôt.
Créez votre branche de fonctionnalité (git checkout -b feature/NewFeature).
Commitez vos changements (git commit -am 'Add NewFeature').
Poussez vers la branche (git push origin feature/NewFeature).
Ouvrez une Pull Request.
Licence
Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus d’informations.
