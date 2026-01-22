;; Problème PDDL: Nord-Kivu
;; Objectif: Produire du café avec terrasses

(define (problem nord-kivu-2030)
  (:domain agriculture-rdc)
  
  (:objects
    nord-kivu - province
    cafe the quinquina - culture
    plants-cafe plants-the amendement - ressource
    terrasses irrigation-montagne - infrastructure
  )
  
  (:init
    ;; État initial
    (terrain-disponible nord-kivu)
    
    ;; Ressources
    (ressource-disponible plants-cafe)
    (ressource-disponible plants-the)
    (ressource-disponible amendement)
    
    ;; Infrastructures
    (infrastructure-presente terrasses nord-kivu)
    (infrastructure-presente irrigation-montagne nord-kivu)
    
    ;; Cultures adaptées
    (culture-adaptee cafe nord-kivu)
    (culture-adaptee the nord-kivu)
    (culture-adaptee quinquina nord-kivu)
  )
  
  (:goal (and
    (production-recoltee nord-kivu cafe)
    (irrigation-active nord-kivu)
    (rendement-ameliore nord-kivu cafe)
  ))
)