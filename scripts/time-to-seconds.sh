tr -d 's' | awk -Fm '{print $1*60 + $2}'
