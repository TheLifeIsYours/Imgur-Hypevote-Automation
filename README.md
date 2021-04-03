# Hypevote Automation
For April 1. 2021, Imgur had their annual April fools prank, and this time addign a little extra feature to their post voting system. This year they introduced **Hypevotes!**

**[Turn one upvote into many by HYPE VOTING!](https://imgur.com/gallery/J9dUKdY)**
[![Imgur Hypevote Demo](https://i.imgur.com/OfUvxbO.gif)](https://imgur.com/gallery/J9dUKdY)


Hypevotes allowed users to upvote a post by 50 points, if they managed to click fast enough that is.
Their Hypevote event is directly inspired by their Melee mobile, gaming oriented app. Where the voting system is exactly the same as hypevoting, but not as a joke, you get to tap to dish out votes/exp to a users post or comment, up to 50 points!

With a lot of tapping comes great wrist strain... try to click as fast as you can within 5 seconds, 50 times!
It's not an easy feat, at least not if you're encouraged to do it all day...

So instead of possibly ruining my future carrier, straining my wrists on repetetive tasks, a developer does what a developer does best... Automation! 🥳

## Hypevote automation
**Autoamting the Hypevoting trough the browser develoepr console**

The site autmation is pretty straight forward.
* You have one button to press 50 times within 5 seconds.
* Navigate to next post in the feed.
* Hyper vote again!

The few limitations we have, is that if the feed ends, we have to get back to the start of the feed. With imgur, since the whole site is a React SPA, we can navigate freely without having to re-apply our code after a page navigation. So we can even automate that process.

Now all we have to do is:
* check wether we're at the end of line
* navigate back to the front page
* open up the first post we can find
* and start the hypevoting!
#### [hype_vote_auto_clicker.js](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/hype_vote_auto_clicker.js)
[![hype_vote_auto_clicker.js](https://i.imgur.com/SaB8G9e.png)](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/hype_vote_auto_clicker.js)

## Hypevote logging
**Logging total Hypevotes with bash and shell script**

Alongside the automation, I was inspired by other imgurians to log the rate of votes over time.

I didn't know strictly where to pull the data from, but what I did know, is that the event banner at the time, displayed different milestones, and how far along the total votes were.

![Imgur Hypevote Event Banner](https://i.imgur.com/rkpXjqf.png)

So I did some digging in the code of the banner, and found out where the banner calculated each progress bar. The banner is using a variable, holding the total amount of votes, since the start of the event.

And to me, that's as good source as any other.
So i set out to pick it apart, and started logging!

![Imgur Hypevote Event Banner Code](https://i.imgur.com/Z2R6Pxo.png)  
**Small summary of the banner code**  
For each bar, get the percentage of how far along are we to the next milestone, and in the end subtracting the milestone from the total hype, if there are more than zero totalHype points left after the calculation.

### Shell code
What I knew was that I had to pull out the totalHype variable, and what better tool to use than regex?
So I fetched the banner using `curl`, and matched the score out with a capture group.

And since I wanted to get the score in an interval, using my limited shell and bash knowledge, I went for a sleeping while loop. I later learned that you could use `cron` to setup a routine, rather than rely on long running processes. (live and learn, right?)

Inside the loop:
* First check if the response has come back successfully
* then check if the hypeVote value has changed
  * Wether to sleep the loop for longer
  * Or append it to the end of the csv log file.
    * csv contains totalHype points, and a timestamp in ms.

Either way, I wanted to have the script give me feedback on a same line echo, wether or not the value has updated.

#### [hype_votes.sh](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/hype_votes.sh)
[![hype_votes.sh](https://i.imgur.com/u88RvoV.png)](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/hype_votes.sh)

# Log Result
The log results has some hickups here and there, and that's due to the script hanging from time to time, reason being that there weren't implemented any error checks in the first few itterations of the script. (Also possibly because I got rate limited because of the auto clicker... but we'll just look past that :eyes:)
#### [Hypevotes over time](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/log.csv)
[![](https://i.imgur.com/ZvkPSJE.png)](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/log.csv)
[log.csv](https://github.com/TheLifeIsYours/Imgur-Hypevote-Automation/blob/master/log.csv)
