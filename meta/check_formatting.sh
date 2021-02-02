dart_files=$(git ls-tree --name-only -r HEAD | grep '.dart$')
[ -z "$dart_files" ] && exit 0
unformatted=$(dartfmt -n $dart_files -l 120)
[ -z "$unformatted" ] && exit 0

# Some files are not dartfmt'd. Print message and fail.
echo >&2 "dart files must be formatted with dartfmt. Please run:"
for fn in $unformatted; do
  echo >&2 "  dartfmt -l 120 -w $PWD/$fn"
done

exit 1
