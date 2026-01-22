# Planification Agricole RDC - Système PDDL

## 📋 Vue d'ensemble

Ce projet implémente un système de **planification agricole automatisée** pour la République Démocratique du Congo (RDC) basé sur le langage **PDDL (Planning Domain Definition Language)**. Il utilise le planificateur **PDDL4J** pour générer des plans d'action optimisés pour différentes provinces.

### Objectif principal
Générer des plans d'action agricoles adaptés à chaque province en tenant compte de :
- ✅ Les ressources disponibles (semences, engrais, équipements)
- ✅ Les infrastructures présentes (irrigation, routes)
- ✅ Les cultures adaptées au climat local
- ✅ Les objectifs de production et de rendement

---

## 📚 Domaine PDDL

### Types
- **province** : Zones géographiques (Équateur, Haut-Katanga, Kasaï-Central, Kwilu, Nord-Kivu)
- **culture** : Plantes cultivées (maïs, manioc, banane, café, etc.)
- **ressource** : Intrants agricoles (semences, engrais, équipements)
- **infrastructure** : Installations (irrigation, routes, terrasses)

### Actions (Opérateurs)

| Action | Description | Préconditions | Effets |
|--------|-------------|---------------|--------|
| **preparer-sol** | Prépare le terrain pour la plantation | Terrain disponible + Ressource disponible | Terrain préparé, ressource utilisée |
| **cultiver** | Plante une culture | Terrain préparé + Ressource + Culture adaptée | Culture en cours |
| **irriguer** | Active l'irrigation | Culture en cours + Infrastructure | Irrigation active, rendement amélioré |
| **maturation** | Passage du temps pour la croissance | Culture en cours | Culture mature |
| **recolter** | Récolte la production | Culture en cours + Culture mature | Production récoltée, terrain libéré |

### Prédicats principaux

```lisp
(terrain-disponible ?p - province)       ; Terrain prêt pour la mise en culture
(culture-en-cours ?p - province ?c - culture)
(culture-mature ?p - province ?c - culture)
(production-recoltee ?p - province ?c - culture)
(irrigation-active ?p - province)
(rendement-ameliore ?p - province ?c - culture)
(culture-adaptee ?c - culture ?p - province)
```

---

## 🌾 Provinces et Objectifs

### 1. **Équateur**
- **Cultures cibles** : Manioc, Palmier, Banane
- **Irrigation** : Goutte-à-goutte
- **Objectifs** : Production de manioc avec irrigation et rendement amélioré

### 2. **Haut-Katanga**
- **Cultures cibles** : Maïs, Soja
- **Irrigation** : Pivot
- **Objectifs** : Production de maïs avec irrigation et rendement amélioré

### 3. **Kasaï-Central**
- **Cultures cibles** : Maïs, Arachide, Manioc
- **Irrigation** : Surface
- **Objectifs** : Production de maïs avec irrigation

### 4. **Kwilu**
- **Cultures cibles** : Manioc, Maïs, Banane-Plantain
- **Irrigation** : Traditionnelle
- **Objectifs** : Production de manioc avec irrigation

### 5. **Nord-Kivu**
- **Cultures cibles** : Café, Thé, Quinquina
- **Infrastructure** : Terrasses, Irrigation de montagne
- **Objectifs** : Production de café avec irrigation et rendement amélioré

---

## 🚀 Installation et utilisation

### Prérequis
- Java 8 ou supérieur
- PDDL4J (inclus comme JAR : `pddl4j-3.8.3.jar`)
- Bash (Linux/macOS) ou WSL (Windows)

### Installation

```bash
# Cloner le repository
git clone https://github.com/ychrism/planification-agricole-rdc-pddl.git
cd planification-agricole-rdc-pddl

# Rendre le script exécutable
chmod +x run_planner.sh
```

### Exécution

#### 1. Exécuter tous les plans (recommandé)
```bash
./run_planner.sh
```

#### 2. Exécuter un plan spécifique
```bash
java -Xmx2g -jar pddl4j-3.8.3.jar \
    -p 0 \
    -i 3 \
    -o domain.pddl \
    -f problems/problem_kwilu.pddl
```

#### 3. Visualiser les résultats
```bash
# Voir le plan détaillé
cat results/plan_kwilu.txt

# Voir le résumé
cat results/summary_kwilu.txt
```

### Options PDDL4J

| Option | Description |
|--------|-------------|
| `-o` | Fichier du domaine PDDL |
| `-f` | Fichier du problème PDDL |
| `-p` | Planificateur à utiliser (0 = A*) |
| `-i` | Heuristique (3 = FF) |
| `-Xmx2g` | Allocation mémoire maximale |

---

## 📊 Résultats typiques

### Exemple: Plan pour Kwilu

```
0: (preparer-sol kwilu semences-manioc)        [1]
1: (cultiver kwilu manioc semences-manioc)     [1]
2: (maturation kwilu manioc)                   [1]
3: (irriguer kwilu manioc irrigation-traditionelle) [1]
4: (recolter kwilu manioc)                     [1]

Plan total cost: 5.00
Temps d'exécution: 0.03 secondes
```

---

## 📈 Cas d'usage et applications

### Planification stratégique
- Générer des plans optimisés pour différentes régions agricoles
- Adapter les stratégies selon les ressources locales

### Optimisation des ressources
- Minimiser l'utilisation des ressources rares
- Maximiser le rendement agricole

### Aide à la décision
- Fournir des recommandations aux agriculteurs
- Planifier l'allocation des infrastructures

### Recherche académique
- Étudier les problèmes de planification en milieu contraint
- Développer de nouveaux algorithmes de planification

---

## 🤝 Contribution

Pour contribuer à ce projet :

1. Créer une branche (`git checkout -b feature/mafeature`)
2. Faire les modifications
3. Commiter (`git commit -m 'Ajoute mafeature'`)
4. Pousser (`git push origin feature/mafeature`)
5. Ouvrir une Pull Request

### Améliorations futures
- [ ] Support de nouvelles provinces
- [ ] Ajout de contraintes temporelles
- [ ] Intégration d'une interface web
- [ ] Support du multi-objectif
- [ ] Optimisation pour les problèmes de grande taille

---

## 📝 Auteur

**Yves-Christophane N. MEDAGBE**
- Master IA
- Planification & Automatisation

---

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier LICENSE pour plus de détails.

---

## 📞 Support et Questions

Pour toute question ou problème :
- 📧 Ouvrir une issue sur GitHub
- 💬 Consulter la documentation PDDL4J
- 📚 Référence PDDL : [Planning Domain Definition Language](https://planning.wiki/)
