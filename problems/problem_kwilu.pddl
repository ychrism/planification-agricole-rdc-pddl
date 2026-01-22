;; Problème PDDL: Kwilu
;; Objectif: Produire du manioc et du maïs

(define (problem kwilu-2030)
  (:domain agriculture-rdc)
  
  (:objects
    kwilu - province
    manioc mais banane-plantain - culture
    semences-manioc semences-mais engrais-organique - ressource
    irrigation-traditionelle pistes - infrastructure
  )
  
  (:init
    ;; État initial
    (terrain-disponible kwilu)
    
    ;; Ressources
    (ressource-disponible semences-manioc)
    (ressource-disponible semences-mais)
    (ressource-disponible engrais-organique)
    
    ;; Infrastructures
    (infrastructure-presente irrigation-traditionelle kwilu)
    (infrastructure-presente pistes kwilu)
    
    ;; Cultures adaptées
    (culture-adaptee manioc kwilu)
    (culture-adaptee mais kwilu)
    (culture-adaptee banane-plantain kwilu)
  )
  
  (:goal (and
    (production-recoltee kwilu manioc)
    (irrigation-active kwilu)
  ))
)