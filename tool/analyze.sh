OUTPUT="$(flutter analyze || true)"
echo "$OUTPUT"
echo
if grep -q "error •" <<<"$OUTPUT"; then
  echo "flutter analyze found errors"
  exit 1
elif grep -q "warning •" <<<"$OUTPUT"; then
  echo "flutter analyze found warnings"
  exit 1
elif grep -q "info •" <<<"$OUTPUT"; then
  echo "flutter analyze found infos"
  exit 1
else
  echo "flutter analyze didn't find any issues"
  exit 0
fi
