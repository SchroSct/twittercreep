#!/bin/bash
savepath=""
creep(){
username="$1"
if cd "$savepath"
then
   if [[ -d "${username}" ]]
   then
      echo "${username} exists, crawling."
   else
      mkdir "${username}"
   fi
   if cd "${username}"
   then
      mapfile -t links < <(curl -s "https://twitter.com/i/profiles/show/${username}/media_timeline?include_available_features=1&include_entities=1&reset_error_state=false" | sed -e 's/\\n/\n/g' -e 's/\\//g' | grep -e "data-src" -e "img src" | sed -e 's/.*data-src="/https:\/\/twitter.com/g' -e 's/\?.*//g' -e 's/.*img src="//g' -e 's/".*//g')
      maxid=$(curl -s "https://twitter.com/i/profiles/show/${username}/media_timeline?include_available_features=1&include_entities=1&reset_error_state=false" | sed -e 's/\\n/\n/g' -e 's/\\//g' | grep data-tweet-id | tail -n 1 | sed -e 's/.*="//g' -e 's/".*//g')
      for i in "${links[@]}"
      do
            if echo "$i" | grep -i -e "\....$" > /dev/null
            then
               wget -nc "$i"
            else
               youtube-dl --ignore-config -w --no-part -i "$i"
            fi
      done
      until [[ "$maxid" == "" ]]
      do
         mapfile -t links < <(curl -s "https://twitter.com/i/profiles/show/${username}/media_timeline?include_available_features=1&include_entities=1&max_position=${maxid}&reset_error_state=false" | sed -e 's/\\n/\n/g' -e 's/\\//g' | grep -e "data-src" -e "img src" | sed -e 's/.*data-src="/https:\/\/twitter.com/g' -e 's/\?.*//g' -e 's/.*img src="//g' -e 's/".*//g')
         maxid=$(curl -s "https://twitter.com/i/profiles/show/${username}/media_timeline?include_available_features=1&include_entities=1&max_position=${maxid}&reset_error_state=false" | sed -e 's/\\n/\n/g' -e 's/\\//g' | grep min_position | sed -e 's/.*position"\:"//g' -e 's/".*//g')
         for i in "${links[@]}"
         do
            if echo "$i" | grep -i -e "\....$" > /dev/null
            then
               wget -nc "$i"
            else
               youtube-dl --ignore-config -w --no-part -i "$i"
            fi
         done
         sleep 1
      done
   fi
else
   echo "TWITTERCREEP FAILED"
fi
}
if cd "$savepath"
then
   mapfile -t usernames < <(cat twittercreep.txt)
   for i in "${usernames[@]}"
   do
      creep "$i"
   done
else
   echo "COULD NOT ENTER DIRECTORY"
fi
