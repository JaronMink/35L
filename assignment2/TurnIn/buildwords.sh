#! /bin/sh
head -n 985 | tail -n 957 | egrep '<td>.+<\/td>' |
sed -n '1~2!p' | sed 's/.*<td>\(.*\)<\/td>$/\1/g' |
sed 's/<u>//g' | sed 's/<\/u>//g' | tr '`' "'" |
tr -s ', ' '[\n*]' | tr -s '[:upper:]' '[:lower:]' | sort -u
