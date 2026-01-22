;; Domaine PDDL pour la planification agricole en RDC
;; Auteur: Yves-Christophane N. MEDAGBE
;; Date: Janvier 2025

(define (domain agriculture-rdc)
  (:requirements :strips :typing)
  
  (:types 
    province culture ressource infrastructure - object
  )
  
  (:predicates
    ;; États du terrain
    (terrain-disponible ?p - province)
    (terrain-prepare ?p - province)
    
    ;; États des cultures
    (culture-en-cours ?p - province ?c - culture)
    (culture-mature ?p - province ?c - culture)
    (production-recoltee ?p - province ?c - culture)
    
    ;; Ressources
    (ressource-disponible ?r - ressource)
    (ressource-utilisee ?r - ressource ?p - province)
    
    ;; Infrastructures
    (infrastructure-presente ?i - infrastructure ?p - province)
    (irrigation-active ?p - province)
    (rendement-ameliore ?p - province ?c - culture)
    
    ;; Contraintes d'adaptation
    (culture-adaptee ?c - culture ?p - province)
  )
  
  ;; Action 1: Préparer le sol
  (:action preparer-sol
    :parameters (?p - province ?r - ressource)
    :precondition (and 
      (terrain-disponible ?p)
      (ressource-disponible ?r)
    )
    :effect (and 
      (terrain-prepare ?p)
      (not (terrain-disponible ?p))
      (ressource-utilisee ?r ?p)
    )
  )
  
  ;; Action 2: Cultiver
  (:action cultiver
    :parameters (?p - province ?c - culture ?r - ressource)
    :precondition (and 
      (terrain-prepare ?p)
      (ressource-disponible ?r)
      (culture-adaptee ?c ?p)
    )
    :effect (and 
      (culture-en-cours ?p ?c)
      (not (terrain-prepare ?p))
    )
  )
  
  ;; Action 3: Irriguer
  (:action irriguer
    :parameters (?p - province ?c - culture ?i - infrastructure)
    :precondition (and 
      (culture-en-cours ?p ?c)
      (infrastructure-presente ?i ?p)
    )
    :effect (and 
      (irrigation-active ?p)
      (rendement-ameliore ?p ?c)
    )
  )
  
  ;; Action 4: Maturation (passage du temps)
  (:action maturation
    :parameters (?p - province ?c - culture)
    :precondition (culture-en-cours ?p ?c)
    :effect (culture-mature ?p ?c)
  )
  
  ;; Action 5: Récolter
  (:action recolter
    :parameters (?p - province ?c - culture)
    :precondition (and 
      (culture-en-cours ?p ?c)
      (culture-mature ?p ?c)
    )
    :effect (and 
      (production-recoltee ?p ?c)
      (terrain-disponible ?p)
      (not (culture-en-cours ?p ?c))
      (not (culture-mature ?p ?c))
    )
  )
)