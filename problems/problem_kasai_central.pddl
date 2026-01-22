;; Problème PDDL: Kasaï-Central
;; Objectif: Produire du maïs et de l'arachide

(define (problem kasai-central-2030)
  (:domain agriculture-rdc)
  
  (:objects
    kasai-central - province
    mais arachide manioc - culture
    semences-mais semences-arachide engrais - ressource
    irrigation-surface routes - infrastructure
  )
  
  (:init
    ;; État initial
    (terrain-disponible kasai-central)
    
    ;; Ressources
    (ressource-disponible semences-mais)
    (ressource-disponible semences-arachide)
    (ressource-disponible engrais)
    
    ;; Infrastructures
    (infrastructure-presente irrigation-surface kasai-central)
    (infrastructure-presente routes kasai-central)
    
    ;; Cultures adaptées
    (culture-adaptee mais kasai-central)
    (culture-adaptee arachide kasai-central)
    (culture-adaptee manioc kasai-central)
  )
  
  (:goal (and
    (production-recoltee kasai-central mais)
    (irrigation-active kasai-central)
  ))
)