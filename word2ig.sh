#!/bin/bash
##########################
IFS=$' \n\t'; 
##########################
if printf %b "$0"|grep -qE "bash|-bash"; 
then wfol="${PWD}"; 
else wfol="${0%/*}"; 
fi; cd $wfol; ko=0; 
##########################
######### get word #######
mv $wfol/img/* -t $HOME/logs/t 2>/dev/null; 
mkdir -pm 775 $wfol/img/s 2>/dev/null; 
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
printf %b "\n---- $wo ----\n"; 
##########################
for ww in ${wo[*]}; do 
#### PRINT PANGO FILE ####
#### WORD ################
(printf %b "\e[38;5;236m$ww" \
| ansifilter -F serif -s 270 -M; 
echo "  "| ansifilter -s 24 -M; 
##########################
#### PHONETICS ###########
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
echo; echo $((ko++)); echo; 
convert -gravity center -background "#f5f5f5" pango:"$(cat $wfol/log/$ww.xml)" "${wfol}/log/${ww}.jpg" 2>/dev/null; 
##########################
echo; echo $((ko++)); echo; 
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
convert -gravity center -background "#f5f5f5" "${wfol}/log/${ww}.jpg" -extent ${mz}x${mz} ${wfol}/img/${ww}_p.jpg 2>/dev/null; 
echo; echo $((ko++)); echo; 
convert ${wfol}/img/${ww}_p.jpg -resize 1440 ${wfol}/img/${ww}.jpg 2>/dev/null; 
rm ${wfol}/img/${ww}_p.jpg 2>/dev/null; 
##########################
echo; echo $((ko++)); echo; 
##########################
convert -gravity center -background "#f5f5f5" "${wfol}/log/${ww}.jpg" -extent ${mz}x${mz16} ${wfol}/img/s/${ww}_p.jpg 2>/dev/null;
convert ${wfol}/img/s/${ww}_p.jpg -resize 1440 ${wfol}/img/s/${ww}.jpg 2>/dev/null; 
rm ${wfol}/img/s/${ww}_p.jpg; 
##########################
echo; echo $((ko++)); echo; 
##########################
rm "${wfol}/log/${ww}.jpg" "${wfol}/log/${ww}.xml"; 
##########################
cp $wfol/w/$ww.log $wfol/up/$ww.log 2>/dev/null; 
printf %b "\n-\e[222b"; 
##########################
sed -i '/<\/div><\/body><\/html>/d' $wfol/index.html; 
##########################
printf %b "\n-\e[222b\n$(date --rfc-email)\n$ww\n" >> $HOME/logs/wlog.log; 
##########################
printf %b "<br><hl><br><div class="kk"><code>$(cat ${wfol}/w/${ww}.log|sed "i<br>")</code><br><img src="https://raw.githubusercontent.com/12ants/iimg/main/${ww}.jpg"></div><br><hl><br>
</div></body></html>
"|tee -a ${wfol}/index.html; 
printf %b "-\e[222b\n\n"; 
pwdd="$(pwd)"; cd ${wfol}; 
##########################
printf %b "\n\n -- run from: $wfol\n -- $ww --\n\n"; 
##########################
done; 
##########################
echo; echo $((ko++)); echo; 
(date --rfc-email; echo $wfol/$igword)|tee -a $HOME/logs/wl.log; 
##########################
cd $wfol; 
##########################
(date --rfc-email; echo $wfol/$igword)|tee -a $HOME/logs/wl.log; 
####
##########################
####
#### UPLOADER ####
####
IFS=$' \n\t'; 
##########################
if printf %b "$0"|grep -qE "bash|-bash"; then wfol="${PWD}"; else wfol="${0%/*}"; fi; cd $wfol; 
##########################
igword="$(ls -1rt --group-directories-first $wfol/img|tail -n1)"; igcap="$(sed -n 4p $wfol/w/${igword/.*/}.log)"; igaccount="17841477140456200"; igtoken="IGAAIcnwJCEa1BZAFktNTg4cWZAyZAXZAWb3VWWjNGbnRBZADBIYU5kakdmbmdGV2RHMkR3WDhpR2ppeXh5Mkc0VkdsVVdScFRRMllBWjFXTzdXemZAfTm9oa0xtTTBRQlJXVzBtTWlpX0pYbDB1ZADZAiUUJUVEpRQmt2Um5MSWpFR2pVawZDZD"; 
##########################
echo; echo $((ko++)); echo; 
##########################
iimgf="$HOME/gh/iimg"; 
##########################
cp $wfol/img/$igword -t $iimgf; 
cp $wfol/img/s/$igword -t $iimgf/s; 
rm $wfol/img/s/$igword;  
rm $wfol/img/$igword;  
##########################
cd $iimgf; 
printf %b "-\e[222b"; 
git add ./; 
git commit -a -m gg; 
git push; 
printf %b "-\e[222b"; 
cd $wfol; 
printf %b "-\e[222b"; 


git add ./; git commit -a -m gg; git push; 
printf %b "-\e[222b\n"; 
cd $pwdd; 
for i in {1..18}; do echo "$i"; sleep 1; done; echo; 
##########################
igfeedurl="https://raw.githubusercontent.com/12ants/iimg/main/${igword}"; 
igstoryurl="https://raw.githubusercontent.com/12ants/iimg/main/s/${igword}"; 
printf %b "\n --\n"; printf %b " -- feed  - $igfeedurl"; printf %b "\n --\n"; printf %b " -- story - $igstoryurl"; 
####
#### post to feed 
for i in {1..8}; do echo "$i"; sleep 1; done; printf %b "\n -- uploading from url: $igfeedurl\n -- to feed --\n\n"; igfeed="$(curl -sX POST "https://graph.instagram.com/v25.0/${igaccount}/media" -F "image_url=${igfeedurl}" -F "caption=${igcap}" -F "access_token=${igtoken}"|cut -f2- -d":"|tr -d '\"{}')"; 
echo "15"; for i in {1..15}; do echo "$i"; sleep 1; done; 
igfeed2="$(curl -sX POST "https://graph.instagram.com/v25.0/"${igaccount}"/media_publish" -H "Content-Type: application/json" -H "Authorization: Bearer "${igtoken}"" -d "{ "creation_id":"${igfeed}" }")"; [ "$igfeed" ] && printf %b "\n -- \e[92msuccess\e[0m ! $igfeed \n"; sleep 1; 
####
####
####
#### post to stories 
####
printf %b "\n -- uploading from url: $igstoryurl\n -- to stories --\n\n"; 
igstory="$(curl -sX POST "https://graph.instagram.com/v25.0/${igaccount}/media" -F "media_type=STORIES" -F "image_url=${igstoryurl}" -F "access_token=${igtoken}"|cut -f2- -d":"|tr -d '\"{}')"; 
echo "15"; for i in {1..15}; do echo "$i"; sleep 1; done; 
igstory2="$(curl -sX POST "https://graph.instagram.com/v25.0/"${igaccount}"/media_publish" -H "Content-Type: application/json" -H "Authorization: Bearer "${igtoken}"" -d "{ "creation_id":"${igstory}" }")"; 
####
printf %b "\n -- uploading token to STORIES: $igstory2\n"; 
##########################
##########################
(date --rfc-email; echo -e "\ndone\n$wfol/$igword\ndone\n")|tee -a $HOME/logs/wl.log; 
##########################
##########################
