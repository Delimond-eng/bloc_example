# Flutter_bloc explain

Flutter bloc est un gestionnaire d'etat(state manager) !
Pour utiliser à mieux bloc, il faut installer ces dependances :  
# flutter_bloc,
le package officiel pour flutter ou
# bloc
le package spécifique pour dart
# equatable
Le package qui permet de vous eviter de coder les methodes d'égalités et le hashCode !
A titre d'exemple :
En dart normalement si compare deux instance, cela va retourner *False*
*
    var todo1 = new Todo(id:1, task:"Lorem", description:"ipsum");
    var todo2 = new Todo(id:1, task:"Lorem", description:"ipsum");
    todo1==todo2 /*Avec dart ça retournera false*/
*

En revanche, avec l'utilisation du package *Equatable* ces genres de problèmes est géré automatique !


# Demarche à suivre

Créer dans le dossier *lib* un dossier *bloc*, lequel va contenir vos *dossier bloc*
dans ce petit projet, nous avons utilisé *todo* !
