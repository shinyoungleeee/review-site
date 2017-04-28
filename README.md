# review-site

![Build Status](https://codeship.com/projects/b4c0dc60-0687-0135-1c2c-4ed15a318303/status?branch=master)
![Code Climate](https://codeclimate.com/github/shinyoungleeee/review-site.png)
![Coverage Status](https://coveralls.io/repos/shinyoungleeee/review-site/badge.png)

#Description
This site is a simple review site based upon the concept of reviewing memes. Our site was built on Rails but utilizes React to render parts of our front-end. Our app was built in the mindset of test driven development and has 82 tests that test both Rails and React using rspec and Jasmine respectively. Postgres is our database. We utilize the devise gem for user authentication and the carrierwave-aws gem for cloud storage when uploading profile photos. Users do not have the ability to post memes if they are not an admin. An admin has the ability to make other users admins. An admin can also delete any meme, review, or even users how they see fit.



### Setup
* To set up the site on a local machine, clone down the repo
* Run `bundle`
* Run `npm install`
* Run `rake db:migrate`
* To check testing run command `rake test:prepare` and then run rake
* To get localhost running on personal machine run `rails s` on the terminal
* In another tab run `npm start`
* Visit (http://localhost:3000/)

* To see the official website visit (http://take-on-meme.herokuapp.com/)




### Getting Started
* Click Join or Sign In in order to post reviews on the site.
* Click on either name or picture of meme in order to access the show page for a specific meme.
* Once on the show page, a logged in user will have the ability to post a review, or vote on other reviews.
* A logged in User will only be able to post one review
* A logged in User has the ability to edit reviews they have posted
* In order to post a meme a user needs admin access
* Once a meme is posted an admin has the ability to edit memes.


* Admins have the added functionality of viewing a list of users
* Admins have the ability to make other users Admins
* Admins have the ability to remove any meme or review they see fit
