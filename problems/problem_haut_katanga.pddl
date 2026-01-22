;; Problème PDDL: Haut-Katanga
;; Objectif: Produire du maïs avec irrigation

(define (problem haut-katanga-2030)
  (:domain agriculture-rdc)
  
  (:objects
    haut-katanga - province
    mais soja - culture
    semences-mais engrais equipement - ressource
    irrigation-pivot routes - infrastructure
  )
  
  (:init
    ;; État initial du terrain
    (terrain-disponible haut-katanga)
    
    ;; Ressources disponibles
    (ressource-disponible semences-mais)
    (ressource-disponible engrais)
    (ressource-disponible equipement)
    
    ;; Infrastructures présentes
    (infrastructure-presente irrigation-pivot haut-katanga)
    (infrastructure-presente routes haut-katanga)
    
    ;; Adaptations culturales
    (culture-adaptee mais haut-katanga)
    (culture-adaptee soja haut-katanga)
  )
  
  (:goal (and
    ;; Objectifs de production
    (production-recoltee haut-katanga mais)
    
    ;; Objectifs d'infrastructure
    (irrigation-active haut-katanga)
    (rendement-ameliore haut-katanga mais)
  ))
)