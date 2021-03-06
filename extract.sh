

for i in "$@"; do
	b=`basename "$i" .md`
	tmpl="tests/$b.nit"
	res="tests/$b.res"
	# Magic to extract the template
	perl -ne 'print if(/~~~nit/ ... /~~~/);' "$i" | tac | sed -ne '1,/~~~/{/~~~/!p}' | tac > "$tmpl"
	# Magic to extract the result
	perl -ne 'print if(/~~~/ ... /~~~/);' "$i" | tac | sed -ne '1,/~~~/{/~~~/!p}' | tac > "$res"

	if ! grep -q '^\s*# CODE HERE\s*$' "$tmpl"; then
		if ! grep -q '^\s*# CHANGE BELOW\s*$' "$tmpl"; then
			echo "$i: no CODE HERE nor CHANGE BELOW"
			rm "$tmpl" "$res"
			continue
		fi
		if ! grep -q '^\s*# CHANGE ABOVE\s*$' "$tmpl"; then
			echo "$i: no CHANGE ABOVE"
			rm "$tmpl" "$res"
			continue
		fi
	fi
	echo "$i `wc -l "$tmpl"` `wc -l "$res"`"
done
