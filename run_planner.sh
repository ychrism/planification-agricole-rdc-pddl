#!/bin/bash
# run_planner.sh - Exécuter PDDL4J sur toutes les provinces

echo "=== Planification Agricole RDC - Exécution PDDL4J ==="
echo "Date: $(date)"
echo ""

# Variables
DOMAIN="domain.pddl"
PROBLEMS_DIR="problems"
RESULTS_DIR="results"
PDDL4J="pddl4j-3.8.3.jar"

# Vérifier si le JAR existe
if [ ! -f "$PDDL4J" ]; then
    echo "Erreur: pddl4j-4.0.0.jar non trouvé!"
    exit 1
fi

# Vérifier le domaine
if [ ! -f "$DOMAIN" ]; then
    echo "Erreur: $DOMAIN non trouvé!"
    exit 1
fi

# Créer le dossier results
mkdir -p "$RESULTS_DIR"

echo "Classpath: (simplifié)"
echo "Domaine: $DOMAIN"
echo "Dossier problèmes: $PROBLEMS_DIR/"
echo "Dossier résultats: $RESULTS_DIR/"
echo ""

# Liste des provinces
PROVINCES=("haut_katanga" "equateur" "kasai_central" "nord_kivu" "kwilu")

TOTAL_SUCCESS=0
TOTAL_FAILED=0

for province in "${PROVINCES[@]}"; do
    PROBLEM="$PROBLEMS_DIR/problem_${province}.pddl"
    OUTPUT="$RESULTS_DIR/plan_${province}.txt"
    SUMMARY="$RESULTS_DIR/summary_${province}.txt"
    
    if [ ! -f "$PROBLEM" ]; then
        echo "⚠ Fichier non trouvé: $PROBLEM"
        continue
    fi
    
    province_name=$(echo "$province" | tr '_' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    echo "--- $province_name ---"
    
    # Exécuter PDDL4J 
    echo "Exécution en cours..."
    START_TIME=$(date +%s.%N)
    
    # Commande corrigée
    java -Xmx2g -jar "$PDDL4J" \
        -p 0 \
        -i 3 \
        -o "$DOMAIN" \
        -f "$PROBLEM" > "$OUTPUT" 2>&1
    
    EXIT_CODE=$?
    END_TIME=$(date +%s.%N)
    EXECUTION_TIME=$(echo "$END_TIME - $START_TIME" | bc)
    
    # Analyser les résultats
    if grep -q "found plan as follows" "$OUTPUT"; then
        echo "✅ SUCCÈS: Plan trouvé"
        STATUS="SUCCÈS"
    
        
        # Sauvegarder un résumé
        cat > "$SUMMARY" << EOF
PROVINCE: ${province_name}
STATUS: SUCCÈS
TOTAL_TIME: ${EXECUTION_TIME}s
EXIT_CODE: ${EXIT_CODE}

--- PLAN ---
$(grep -A 50 "found plan as follows" "$OUTPUT" | tail -n +2 | head -30)
EOF
        
        TOTAL_SUCCESS=$((TOTAL_SUCCESS + 1))
        
    elif grep -q "unsolvable" "$OUTPUT"; then
        echo "❌ ÉCHEC: Problème insoluble"
        STATUS="INSOLUBLE"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
        
        cat > "$SUMMARY" << EOF
PROVINCE: ${province_name}
STATUS: INSOLUBLE
TOTAL_TIME: ${EXECUTION_TIME}s
EXIT_CODE: ${EXIT_CODE}
EOF
        
    elif [ $EXIT_CODE -ne 0 ]; then
        echo "⚠ ERREUR: Code de sortie $EXIT_CODE"
        STATUS="ERREUR"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
        
        # Capturer les dernières lignes d'erreur
        ERROR_MSG=$(tail -10 "$OUTPUT" | grep -v "^$" | tail -5)
        
        cat > "$SUMMARY" << EOF
PROVINCE: ${province_name}
STATUS: ERREUR
EXIT_CODE: ${EXIT_CODE}
TOTAL_TIME: ${EXECUTION_TIME}s
ERROR_MSG: ${ERROR_MSG}
EOF
        
    else
        echo "❓ INCONNU: Aucun plan trouvé"
        STATUS="INCONNU"
        TOTAL_FAILED=$((TOTAL_FAILED + 1))
    fi
    
    echo ""
done

# Résumé final
echo "=== RÉSUMÉ FINAL ==="
echo "Succès: $TOTAL_SUCCESS / ${#PROVINCES[@]}"
echo "Échecs: $TOTAL_FAILED / ${#PROVINCES[@]}"
echo ""

if [ $TOTAL_SUCCESS -gt 0 ]; then
    echo "📋 Plans générés dans: $RESULTS_DIR/"
    echo "   Fichiers: plan_*.txt (détails) et summary_*.txt (résumé)"
    echo ""
    echo "Pour visualiser un plan:"
    echo "  cat $RESULTS_DIR/plan_haut_katanga.txt | grep -A 20 'found plan'"
fi

echo "=== Exécution terminée ==="