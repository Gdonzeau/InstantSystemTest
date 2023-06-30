# InstantSystemTest

1 - Lecture de l'énoncé :
- Il s'agit de faire un journal, comme la page internet de Le Figaro ou Le monde, mais sous forme d'app iOS.
- Idée de développement : utiliser une tableView qui permettra d'afficher les données demandées : le titre, l'image et pourquoi pas le début du texte.
- Avant d'aller plus loin, s'inscrire sur le site https://newsapi.org/docs obtenir une clé API et tester le call API avec postman.

2 - Mise en place de la requête réseau
- J'ai préféré revoir le cours que j'avais eu sur openClassroom avant : il a été mis à jour et j'ai eu les idées plus claires (je n'avais pas fait de tests unitaires sur les appels réseaux depuis quelque temps déjà). Avec l'expérience acquise entre temps, les concepts de Completion Handler, de callback et de @escaping sont devenus très clairs. 
- Début avec les tests unitaires. Pour ce faire je reprends le code de mon git sur https://github.com/Gdonzeau/P9_MonBaluchon-suite/blob/main/MonBaluchon/Services/WeatherService.swift et j'adapte le code pour correspondre.
- Je place également les tests unitaires. Pour le fichier json, je fais un copier coller du retour sur postman (en reduisant toutefois le nombre de réponses)
- Tests unitaires lancés et couverture du service à 100%
- Ajout dans le viewDidLoad d'une requête réseau pour tester hors tests unitaires (temporaire bien sûr)

3 - Développement de l'interface et mise en place de l'architecture MVVM
- Ayant déjà travaillé en architecture MVVM selon avec SwiftUI, je me suis inpiré de ces deux tutoriaux pour construire l'architecture :
    - https://stevenpcurtis.medium.com/mvvm-in-swift-19ba3f87ed45
    - https://karthikmk.medium.com/ios-mvvm-b3eb4f519d2d
- J'ai développé une tableView avec des cellules personnalisées. Cela me paraît la meilleure option pour afficher des titres de journaux. Au début je souhaitais ajouter le descriptif en plus du titre et de l'image, mais la plupart des titres étant eux-mêmes assez longs, cela ne m'a pas paru pertinent au final.
- J'ai séparé les différentes extensions pour une meilleure lisibilité.
- J'ai installé aussi le retrait du clavier après l'appui de la touche entrée, d'un toucher de l'écran, ou d'autres événements.
- Parmi les problèmes identifiés, il y avait la façon dont devaient être classées les nouvelles (ici, par popularité). Un bouton pull Down ou un Segmented Control peuvent faire l'affaire. Ce n'est pas expressément demandé aussi je le laisse éventuellement pour la suite. Les données reçues seront utilisées dans le createUrl de SearchViewController.
- Après avoir mis en place l'architecture MVVM, j'ai ajusté les tests unitaires et supprimé la partie service qui n'était plus utilisée.

4 - Résolution d'un ticket
- En utilisant l'application ce matin, je me suis aperçu que les images se répétaient. Elles ne se rafraichissaient pas toujours. Voilà donc l'occastion de faire un ticket (en effet, jusqu'à maintenant, le développement était assez linéaire et je restais sur la branche main).
- J'ai créé une nouvelle branche dans laquelle j'ai implémenté le rafraichissement de la cellule.
- Une fois le bug résolu et l'application testée avec succès j'ai fusionné la branche du bug avec la branche main.

5 - Ajout du NewsViewController
- Création d'une nouvelle branche
- Création du NewsViewController
- Implémentation de la transmission de données entres contrôleurs en ajoutant une variable Article.
- Mise en page
- Bouton pour accéder à l'article en entier sur une page internet tout en restant dans l'application.
