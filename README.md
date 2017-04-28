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

#### Authentication User Stories

Your implementation should fulfill the following user stories, add the necessary acceptance tests to be sure functionality is always working properly:

```no-highlight
As a prospective user
I want to create an account
So that I can review them and vote on reviews
```

```no-highlight
As an unauthenticated user
I want to sign in
So that I can post reviews
```

```no-highlight
As an authenticated user
I want to sign out
So that no one else can review on my behalf
```

```no-highlight
As an authenticated user
I want to update my information
So that I can keep my profile up to date
```

```no-highlight
As an authenticated user
I want to delete my account
So that my information is no longer retained by the app
```
#### CRUD User Stories

In a standard CRUD app, each of these operations will correspond to a user story:

* Create

```no-highlight
As an authenticated user
I want to add a review
So that others can vote on it
```

* Read

```no-highlight
As an authenticated user
I want to view a list of items
So that I can pick items to review
```

```no-highlight
As an authenticated user
I want to view the details about an item
So that I can get more information about it
```

* Update

```no-highlight
As an authenticated user
I want to update a review's information
So that I can correct errors or provide new information
```

* Delete

```no-highlight
As an authenticated user
I want to delete a review
So that no one can vote on it
```

#### CRUD Admin Stories

In a standard CRUD app, each of these operations will correspond to a user story:

* Create

```no-highlight
As an admin
I want to add a memes or reviews
So that others can review or vote on it
```

* Read

```no-highlight
As an admin
I want to view a list of users
So that I can pick users to delete or make admin
```

* Update

```no-highlight
As an admin
I want to update a users admin status
So that I can give trusted users the ability to post memes
```

* Delete

```no-highlight
As an admin
I want to delete a user
To ensure bad users cannot log in
```
```no-highlight
As an admin
I want to delete any meme or review
To ensure inappropriate content is removed
```
