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
