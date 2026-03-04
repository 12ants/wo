#!/bin/bash
##########################
IFS=$' \n\t'; 
##########################
if printf %b "$0"|grep -q "bash"; 
then wfol="${PWD}"; 
else wfol="${0%/*}"; 
fi; cd $wfol; 
##########################
######### get word #######
mv $wfol/page/img/* -t $HOME/logs/t 2>/dev/null; 
mkdir -pm 775 $wfol/page/img/s 2>/dev/null; 
mkdir -pm 775 $wfol/log 2>/dev/null; 
mkdir -pm 775 $wfol/up 2>/dev/null; 
######### word variables #
########
wlog=($(basename -s ".log" $wfol/w/*)); 
wzup=($(basename -s ".log" $wfol/up/*)); 
word="$(printf %b "${log[*]}"|tr " " "\n"|grep -vwE "${gre[*]}"|shuf -n1)"; 
##########################
wo="$(while :; do new="$(shuf -en1 ${wlog[*]})"; printf %b "${wzup[*]}"|grep -qwe ${new} || break; done; printf %b "$new")"; 
##########################
for ww in ${wo[*]}; do 
#### PRINT PANGO FILE ####
#### WORD ################
(printf %b "\e[38;5;236m$ww" \
| ansifilter -F serif -s 270 -M; 
echo "  "| ansifilter -s 24 -M; 
##########################
#### PHONETITS ###########
(printf %b "\e[38;5;249m[\e[0m"; 
sed -n 2p $wfol/w/$ww.log|bat -ppf --language d --theme "TwoDark"|tr -d "\n"; 
printf %b "\e[38;5;249m]") \
| ansifilter -MF mono -s 88
##########################
## TYPE ##################
(printf %b "\e[38;5;24m"; 
sed -n 3p $wfol/w/$ww.log; ) \
| ansifilter -F monospace -Ms 88;
echo "  "| ansifilter -Ms 58; 
##########################
## MEANING ###############
(printf %b "\e[38;5;244m"; 
sed -n 4p $wfol/w/$ww.log|tr -d "\n"|fmt -g 22 ) \
| ansifilter -F monospace -Ms 78; 
echo "  "|ansifilter -s 40 -M; 
) > $wfol/log/$ww.xml; 
##########################
##########################
convert -gravity center -background "#f5f5f5" pango:"$(cat $wfol/log/$ww.xml)" "${wfol}/log/${ww}.jpg" 2>/dev/null; 
##########################
me="${wfol}/log/${ww}.jpg";
mw="$(mediainfo "${wfol}/log/${ww}.jpg" | grep -E 'Width'  | tr -d " :A-z")"; 
mh="$(mediainfo "${wfol}/log/${ww}.jpg" | grep -E 'Height' | tr -d " :A-z")";
##########################
[ "$mw" -gt "$mh" ] && mx="$mw" || mx="$mh";
##########################
mz1="$((mx / 2 + 850))"; 
##########################
mz="$((mx + mz1))"; 
mz16="$((mz * 16 / 9))"; 
##########################
convert -gravity center -background "#f5f5f5" "${wfol}/log/${ww}.jpg" -extent ${mz}x${mz} ${wfol}/page/img/${ww}_p.jpg 2>/dev/null; 
convert ${wfol}/page/img/${ww}_p.jpg -resize 1440 ${wfol}/page/img/${ww}.jpg 2>/dev/null; 
rm ${wfol}/page/img/${ww}_p.jpg 2>/dev/null;
##########################
convert -gravity center -background "#f5f5f5" "${wfol}/log/${ww}.jpg" -extent ${mz}x${mz16} ${wfol}/page/img/s/${ww}_p.jpg 2>/dev/null;
convert ${wfol}/page/img/s/${ww}_p.jpg -resize 1440 ${wfol}/page/img/s/${ww}.jpg 2>/dev/null; 
##########################
rm ${wfol}/page/img/s/${ww}_p.jpg 2>/dev/null; 
rm "${wfol}/log/${ww}.jpg" "${wfol}/log/${ww}.xml"; 
cp $wfol/w/$ww.log $wfol/up/$ww.log 2>/dev/null; 
##########################
sed -i '/<\/div><\/body><\/html>/d' $wfol/page/index.html; 
##########################
printf %b "\n-\e[222b\n$(date --rfc-email)\n$ww\n" >> $HOME/logs/wlog.log; 
printf %b "<br><hl><br><code>$(cat ${wfol}/w/${ww}.log|sed "i<br>")</code><br><img src="/img/${ww}.jpg"><br><hl>
</div></body></html>
"|tee -a ${wfol}/page/index.html; 
pwdd="$(pwd)"; cd ${wfol}/page; 
##########################
printf %b "\n\n -- run from: $0 -- wfol=$wfol\n\n -- $ww --\n\n"; 
##########################
done; 
(date --rfc-email; echo $0/$ww)|tee -a $HOME/logs/wl.log; 
##########################
# sleep 125; #### to be on the safe side 
cd $wfol; 
git add ./; git commit -a -m "${USER}_${modo//\ /}" -v; git pull; git push; 
(date --rfc-email; echo $0/$ww)|tee -a $HOME/logs/wl.log; 
# sleep 11; 
## npx wrangler --cwd $wfol/page pages deploy ./; echo; 
####
############################################################################################################
############################################################################################################
####
#### UPLOADER ####
####
IFS=$' \n\t'; 
####
ig_url="https://zzzzwords.pages.dev"; 
####
if printf %b "$0"|grep -q "bash"; 
then wfol="${PWD}"; 
else wfol="${0%/*}"; 
fi; cd $wfol; 
##########################
ig_word="$(ls -1rt --group-directories-first $wfol/page/img|tail -n1)"; 
ig_cap="$(sed -n 4p $wfol/w/${ig_word/.*/}.log)"; 
ig_account="17841477140456200"; 
ig_token="IGAAIcnwJCEa1BZAFktNTg4cWZAyZAXZAWb3VWWjNGbnRBZADBIYU5kakdmbmdGV2RHMkR3WDhpR2ppeXh5Mkc0VkdsVVdScFRRMllBWjFXTzdXemZAfTm9oa0xtTTBRQlJXVzBtTWlpX0pYbDB1ZADZAiUUJUVEpRQmt2Um5MSWpFR2pVawZDZD"; 
##########################
ig_f="$(curl -X POST "https://anh.moe/api/1/upload" -H "X-API-Key: anh.moe_public_api" -F "source=@${wfol}/${ig_word}" -F "format=json" -s|sed -e "s/\,/\n/g" -e "s/\\\//g" -e 's/\"//g'|grep -e 'url:' -m1|cut -f2- -d":")"; 
##########################
ig_s="$(curl -X POST "https://anh.moe/api/1/upload" -H "X-API-Key: anh.moe_public_api" -F "source=@${wfol}/s/${ig_word}" -F "format=json" -s|sed -e "s/\,/\n/g" -e "s/\\\//g" -e 's/\"//g'|grep -e 'url:' -m1|cut -f2- -d":")"; 
##########################
printf %b "\n -- image2ig.sh\n -- ${ig_word}\n -- ${ig_cap}\n -- loading  ... \n" | tee -a $HOME/logs/wl.log; 
printf %b "\n -- uploading from url: $ig_url/img/$ig_word\n -- to ig_feed ... \n" | tee -a $HOME/logs/wl.log; 
####
cd ${wfol}/page; 
####
for i in {1..8}; do printf %b "$i"; sleep 1; done; echo; 
#### post to feed 
ig_feed="$(curl -sX POST "https://graph.instagram.com/v25.0/${ig_account}/media" -F "image_url=${ig_f}" -F "caption=${ig_cap}" -F "access_token=${ig_token}"|cut -f2- -d":"|tr -d '\"{}')"; 
####
if [ $ig_feed ]; then printf %b "\n -- \e[92msuccess\e[0m ! \n"; 
printf %b " -- counting to 5 ... "; for i in {1..5}; do printf %b "$i "; sleep 1; done; printf %b " ok \n"; 
####
else printf %b "\n -- error @ "; date --rfc-email; return 0; fi; 
####
####
printf %b "\n -- uploading token to FEED: $ig_feed\n"; 
####
ig_feed2="$(curl -sX POST "https://graph.instagram.com/v25.0/"${ig_account}"/media_publish" -H "Content-Type: application/json" -H "Authorization: Bearer "${ig_token}"" -d "{ "creation_id":"${ig_feed}" }")"; 
(date --rfc-email; echo $0/$ww)|tee -a $HOME/logs/wl.log; 
####
if [ $ig_feed2 ]; then printf %b "\n -- \e[92msuccess\e[0m ! \n"; fi; 
####
printf %b "\n -- counting to 5 ... "; for i in {1..5}; do printf %b "$i "; sleep 1; done; printf %b " -- gg\n"; 
####
#### post to stories 
printf %b "\n -- uploading from url: $ig_url/img/s/$ig_word\n -- to stories ...\n"; 
####
ig_story="$(curl -sX POST "https://graph.instagram.com/v25.0/${ig_account}/media" -F "media_type=STORIES" -F "image_url=${ig_s}" -F "access_token=${ig_token}"|cut -f2- -d":"|tr -d '\"{}')"; 
####
if [ $ig_story ]; then printf %b "\n -- \e[92msuccess\e[0m ! \n"; fi; 
####
printf %b "\n -- counting to 5 ... "; for i in {1..5}; do printf %b "$i "; sleep 1; done; printf %b " -- gg\n"; 
####
printf %b "\n -- uploading token to STORIES: $ig_story\n"; 
####
ig_story2="$(curl -sX POST "https://graph.instagram.com/v25.0/"${ig_account}"/media_publish" -H "Content-Type: application/json" -H "Authorization: Bearer "${ig_token}"" -d "{ "creation_id":"${ig_story}" }")"; 
if [ $ig_story2 ]; then printf %b "\n -- \e[92msuccess\e[0m ! \n"; fi; 
##########################
printf %b "\n -- gg\n\n\n"; 
##########################
(date --rfc-email; echo end/$0/$ww)|tee -a $HOME/logs/wl.log; 


# upgg() { uukk="$@"; [ -z $uukk ] && printf %b "\n\n\e[Aimage:"; read -rep ' ' -i "$PWD/" "uukk"; kk="$(curl -X POST "https://anh.moe/api/1/upload" -H "X-API-Key: anh.moe_public_api" -F "source=@${uukk}" -F "format=json" -s|sed -e "s/\,/\n/g" -e "s/\\\//g" -e 's/\"//g'|grep -e 'url:' -m1|cut -f2- -d":")"; echo; printf %b "$kk"; echo; }; 
