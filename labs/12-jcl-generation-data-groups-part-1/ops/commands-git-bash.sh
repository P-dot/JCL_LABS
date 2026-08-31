cd /c/Carrera_Ciberseguridad/06_Portfolio_GitHub/JCL_LABS || exit 1

LAB="labs/12-jcl-generation-data-groups-part-1"
ZIP="$HOME/Downloads/12-jcl-generation-data-groups-part-1.zip"
TMP="$HOME/Downloads/lab12-part1-install-tmp"

echo "========== CURRENT REPOSITORY =========="
pwd
git branch --show-current
git status --short
git log -3 --oneline

echo
echo "========== EXTRACT PACKAGE =========="
rm -rf "$TMP"
mkdir -p "$TMP"
unzip -o "$ZIP" -d "$TMP" || exit 1

echo
echo "========== INSTALL LOCAL =========="
rm -rf "$LAB"
cp -r "$TMP/12-jcl-generation-data-groups-part-1" "labs/" || exit 1
rm -rf "$TMP"

echo
echo "========== VERIFY LOCAL STRUCTURE =========="
find "$LAB" -maxdepth 3 -type f | sort

echo
echo "========== VERIFY EVIDENCE IMAGES =========="
find "$LAB/evidence/screenshots" -type f | sort
printf "Screenshot count: "
find "$LAB/evidence/screenshots" -type f | wc -l

echo
echo "========== TEXT SECURITY CHECK =========="
grep -RInE \
'192\.168\.[0-9]{1,3}\.[0-9]{1,3}|10\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|172\.(1[6-9]|2[0-9]|3[01])\.[0-9]{1,3}\.[0-9]{1,3}|([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' \
"$LAB" \
--exclude='*.png' \
--exclude='*.jpg' \
--exclude='*.jpeg' \
|| echo "OK - no private IP/MAC patterns found in text files"

echo
echo "========== REVIEW BEFORE COMMIT =========="
git status --short
git diff -- "$LAB"

echo
echo "========== STAGE ONLY LAB 12 PART 1 =========="
git add "$LAB"

echo
echo "========== STAGED CONTENT =========="
git diff --cached --name-status

echo
echo "========== COMMIT =========="
git commit -m "Add Lab 12 Part 1 GDG fundamentals and generation creation" || exit 1

echo
echo "========== PUSH TO GITHUB =========="
git push origin main || exit 1

echo
echo "========== FETCH REMOTE STATE =========="
git fetch origin || exit 1

echo
echo "========== VERIFY REMOTE FILES =========="
git ls-tree -r --name-only origin/main | \
grep '^labs/12-jcl-generation-data-groups-part-1/' | sort

echo
echo "========== HASH VERIFICATION =========="
echo "LOCAL HEAD:"
git rev-parse HEAD
echo "ORIGIN/MAIN:"
git rev-parse origin/main
echo "REMOTE MAIN:"
git ls-remote origin refs/heads/main

echo
echo "========== FINAL STATUS =========="
git status

echo
echo "========== LAST COMMITS =========="
git log -5 --oneline
