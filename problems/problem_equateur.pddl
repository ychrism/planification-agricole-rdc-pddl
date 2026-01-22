;; Problème PDDL: Équateur
;; Objectif: Produire du manioc et du palmier

(define (problem equateur-2030)
  (:domain agriculture-rdc)
  
  (:objects
    equateur - province
    manioc palmier banane - culture
    semences-manioc plants-palmier fertilisant - ressource
    irrigation-goutte routes-rurales - infrastructure
  )
  
  (:init
    ;; État initial
    (terrain-disponible equateur)
    
    ;; Ressources
    (ressource-disponible semences-manioc)
    (ressource-disponible plants-palmier)
    (ressource-disponible fertilisant)
    
    ;; Infrastructures
    (infrastructure-presente irrigation-goutte equateur)
    (infrastructure-presente routes-rurales equateur)
    
    ;; Cultures adaptées
    (culture-adaptee manioc equateur)
    (culture-adaptee palmier equateur)
    (culture-adaptee banane equateur)
  )
  
  (:goal (and
    (production-recoltee equateur manioc)
    (irrigation-active equateur)
    (rendement-ameliore equateur manioc)
  ))
)