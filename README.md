![Alt text](erd.pdf?raw=true)

# Rails CRUD
## Week 5 Lab - Microblogging Social Network (Reddit)
###### Due Monday, March 07, 2016  
Build Reddit (bookmarks and voting in Rails using Forms and relationships)

## Learning Objectives
After completing this assignment, you should…

* Be able to utilize Forms in Rails
* Be able to add custom routes to your resources


## Performance Objectives
After completing this assignment, you be able to effectively use

* Modeling Data
* Publishing on Heroku


# Details
## Deliverables
* A rails app repo with:
  * Rails 4.2.4
  * Functioning db/seed.rb
* A link to a live Heroku instance


## Requirements
* Reddit is "User-generated news links. Votes promote stories to the front page."
* Each Link should have a "number of positive votes" column
* Posts have many comments, which are displayed on the post's show page


## Normal Mode
Normal mode is a simple, naive, implementation of Reddit
* The homepage should order by the most number of votes
* Clicking on thumbs-up should increment positive vote and redirect you to the home-page
* Clicking on the title should redirect you to the post detail page
* When on the post detail page, you should display the comments beneath the
* I can post a comment and type in my username
![alt text][logo]

[logo]:https://www.dropbox.com/s/1792nckd6pp2epc/reddit.png?dl=1

## Difficult Mode
* Clicking "DOWN" should create a negative vote
* Add a `User` who `has_many` links
* When submitting a link, allow user to select themselves in a drop down

## Epic Mode
* Make the user sign in using `Devise` or similar
* Add Controller testing and Acceptance testing to verify a user clicking a link creates the votes you expect

## Notes
* To launch on heroku, you'll need the [Heroku Toolbelt](https://toolbelt.heroku.com/) and a [Heroku Account](https://signup.heroku.com/login)
 
## Additional Resources
* Read [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
* Read [Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)
* Read [Action Controller Overview](http://guides.rubyonrails.org/action_controller_overview.html)

Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
