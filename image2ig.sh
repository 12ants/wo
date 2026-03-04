#!/bin/bash
## ig ll
IFS=$' \n\t'; 
ig_url="https://main.wowowords.pages.dev"; 
####
if printf %b "$0"|grep -q "bash"; 
then wfol="${PWD}"; 
else wfol="${0%/*}"; 
fi; cd $wfol; 
## wfol="${PWD}"; 
ig_word="$(ls -1rt --group-directories-first $wfol/page/img|tail -n1)"; 
ig_cap="$(sed -n 4p $wfol/w/${ig_word/.*/}.log)"; 
ig_account="17841477140456200"; 
ig_token="IGAAIcnwJCEa1BZAFktNTg4cWZAyZAXZAWb3VWWjNGbnRBZADBIYU5kakdmbmdGV2RHMkR3WDhpR2ppeXh5Mkc0VkdsVVdScFRRMllBWjFXTzdXemZAfTm9oa0xtTTBRQlJXVzBtTWlpX0pYbDB1ZADZAiUUJUVEpRQmt2Um5MSWpFR2pVawZDZD"; 
printf %b "\n -- image2ig.sh\n -- ${ig_word}\n -- ${ig_cap}\n -- loading ...\n"|tee -a $HOME/logs/wl.log; 
####
printf %b "\n -- uploading from url: $ig_url/img/$ig_word\n -- to ig_feed ... \n" | tee -a $HOME/logs/wl.log; 
####
cd ${wfol}/page; 
####
#### post to feed 
ig_feed="$(curl -sX POST "https://graph.instagram.com/v25.0/${ig_account}/media" -F "image_url=${ig_url}/img/${ig_word}" -F "caption=${ig_cap}" -F "access_token=${ig_token}"|cut -f2- -d":"|tr -d '\"{}')"; 
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
####
if [ $ig_feed2 ]; then printf %b "\n -- \e[92msuccess\e[0m ! \n"; fi; 

####
printf %b "\n -- counting to 5 ... "; for i in {1..5}; do printf %b "$i "; sleep 1; done; printf %b " -- gg\n"; 


####
#### post to stories 

printf %b "\n -- uploading from url: $ig_url/img/s/$ig_word\n -- to stories ...\n"; 

ig_story="$(curl -sX POST "https://graph.instagram.com/v25.0/${ig_account}/media" -F "media_type=STORIES" -F "image_url=${ig_url}/img/s/${ig_word}" -F "access_token=${ig_token}"|cut -f2- -d":"|tr -d '\"{}')"; 
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
# else printf %b "\n\e[91m error \e[0m -- ---- ! \n"; fi; 

printf %b "\n -- gg\n\n\n"; 
##########################
