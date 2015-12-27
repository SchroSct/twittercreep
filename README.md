# twittercreep
===========
---
**DISCLAIMER:**

This code is posted for informational purposes only. Use of Twitter is governed by the company's Terms of Use. Any user content posted to Twitter is governed by the Privacy Policy.


===========
---
**Requirements**

Nothing fancy, updated youtube-dl for videos, curl, wget, bash, sed, tail, grep, echo.  Standard GNU/bash.

===========
---
**Setup**

Edit twittercreep.sh and twittercreep-full.sh 'savepath=""' to point to the directory to save files in.

In the same directory, add a text file named twittercreep.txt with a newline delimited list of usernames.

If savepath="/home/user/Pictures/twittercreep/" for example,

then file /home/user/Pictures/twittercreep/twittercreep.txt should contain your list.

===========
---
**Usage**

twittercreep-full.sh bootstraps the backup, grabbing all posts.  May only need to run this initially, or as a cron to check for items missed by twittercreep.sh updates.

twittercreep.sh monitors the last 20 posts of the user for updates.  Checks in a range of 45 seconds and 6m45s.

twittercreep will populate your savepath with a simple directory structure with the usernames supplied.
