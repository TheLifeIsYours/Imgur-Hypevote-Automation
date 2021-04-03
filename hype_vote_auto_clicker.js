let shouldClick = false

let hypeClick = () => {
  if (shouldClick) {
    //Click automation for hype votes (max 50 votes per post)
    //With added timeout delay to chain clicks out over 5 seconds per post.
    for (let i = 0; i < 50; i++) {
      setTimeout(() => {
        document.querySelector("div.item.btn.btn-upvote").click()
        console.log("clicking")
      }, 90 * i)
    }

    //After clicking, attempt navigation to next post.
    setTimeout(() => {
      //Get the navigation button
      let nextButton = document.querySelector("a.Navigation.Navigation-next")


      //If we actually have a button to click, and go to next post
      //Else we are at eol. and need to navigate to beginning of the feed and start over again.
      if (nextButton) {
        console.log("navigating to next post")
        nextButton.click()
      } else {
        console.log("navigating to usersub")
        document.querySelector(".NavbarContainer-left > div > a").click()
        setTimeout(() => {
          console.log("navigating to first post")
          document.querySelector(".Post-item.vetovote").click()
        }, 2000)
      }
    }, 6000)

    //After page navigating, start new chain of clicks
    setTimeout(() => {
      console.log("starting new click")
      hypeClick()
    }, 8000)
  }
}

// Quick listener for togglign the auto clicker on and off
window.addEventListener('keypress', () => {
  shouldClick = !shouldClick;
  if (shouldClick) {
    hypeClick()
  }
})