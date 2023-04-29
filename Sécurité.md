# Sécurité

La sécurité concerne les 0,001 % des gens mal intentionnés.

Il est sous-entendu que dans l'utilisation de ce qu'on fait, on ne doit se préoccuper que de la logique.

## CORS

Cross Origin Ressource Sharing est une sécurité qui bloque tout appel à notre site, que cet appel soit effectué depuis un navigateur ou un serveur.

https://fr.wikipedia.org/wiki/Cross-origin_resource_sharing

Au sein de mon API, je vais autoriser des origines à venir effectuer des requêtes.

Dans la cadre de l'exercice, nous allons autoriser localhost:5000 à interroger localhost:3000.

Cette sécurité permet notamment de vérifier qui peut utiliser notre API. De plus c'est une protection éventuelle contre les DDOS (https://fr.wikipedia.org/wiki/Attaque_par_d%C3%A9ni_de_service).


Quand on souhaite effectuer un appel au niveau de notre API :

- récupérer la liste des listes
- créer une nouvelle liste
- créer une carte
- ...

Il faut autoriser l'accès à ces routes aux origines qui les utilisent.

https://developer.mozilla.org/fr/docs/Web/HTTP/CORS#Preflighted_requests

## XSS

https://fr.wikipedia.org/wiki/Cross-site_scripting

Le XSS est une problématique à gérer côté client ET serveur.

### Client

Au niveau du client, on va éviter d'utiliser "innerHTML" et le remplacer par "textContent".

L'utilisation du "eval" est à proscrire. Eval permet d'exécuter du code Javascript à partir d'un string.

### Server

Il est de notre responsabilité vis-à-vis de l'intégrité des données et la protection de celles-ci de vérifier chaque envoi fait par un utilisateur.

Il existe plusieurs modules qui permettent de faire ça ("sanitizer","joi"...).

L'idée est de vérifier le body (ou ce qui est envoyé).

On va aller valider que les clefs nécessaires sont là et que le format attendu est respecté.

Par exemple : lors de la réception d'un login/mot de passe, on vérifie bien que le mot de passe respecte les conditions qu'on souhaite mettre en place.

## Injections SQL

L'utilisation de Sequelize permet de se prémunir. Par défaut, il va s'assurer qu'on ne puisse pas faire d'injection SQL.

PG le permet également via les requêtes préparées (utilisation des $1, $2...).

## CSRF

Le Cross-site request forgery (seasurf) est une méthode qui vient à utiliser la session de l'utilisateur et donc les droits qu'il peut avoir au niveau d'une application, pour réaliser des actions dans son dos.

Dans l'idée c'est comme un cheval de Troie, sauf qu'ici la personne vient prendre votre apparence pour s'infiltrer dans le système.

L'attaque va se situer au niveau du client, le pirate prend l'identité de celui-ci.
