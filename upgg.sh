upgg() { 
uukk="$@"; [ -z $uukk ] && printf %b "\n\n\e[Aimage:"; read -rep ' ' -i "$PWD/" "uukk"; 
kk="$(curl -X POST "https://anh.moe/api/1/upload" -H "X-API-Key: anh.moe_public_api" -F "source=@${uukk}" -F "format=json" -s|sed -e "s/\,/\n/g" -e "s/\\\//g" -e 's/\"//g'|grep -e 'url:' -m1|cut -f2- -d":")"; 
echo; 
printf %b "$kk"; 
echo; 
}; 
