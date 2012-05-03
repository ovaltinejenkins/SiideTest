Technical Test For [siide.com](http://www.siide.com/)
==========================================================
Website built in Ruby on Sinatra using Sequel as an ORM.  The project is a blog with basic functionalities.

Technologies:

 * [Sequel](http://sequel.rubyforge.org/)
 * [Sinatra](http://www.sinatrarb.com/)
 
Requirements:

 * Build a simple web app using Sinatra, and Haml for the template language.
 * Deploy it to Heroku. 
 * Use Sequel as your ORM with PostgreSQL (provided by Heroku) for the DB.
 * Keep track of any issues that got in your way, and roughly how long it took.
 
Application Requirements:

 * Create a Post
 * List blog posts
 * Only show 10 blog posts on the main list
 * Have a more button that implements ajax pagination, similar to how siide.com works at the bottom of the page.
 * Edit a blog post
 * Whenever a blog post is created show a add it to the lists page in real time. 

Notes:

 * Database actions are through the Sequel model on the local sqlite database in development and Postgres on Heroku
 * Before this project, I had never used Sinatra or Sequel, but enjoyed using them
	
Issues:

 * One of the issues in working on this was my lack of familiarity with the conventions and standards in the technologies.  I would assume that there are organizational things I have done that are incorrect, especially in the use of some of the routes and paging.
 * There were also issues deploying to Heroku from Windows, and I had to switch to a Linux VM eventually.

Time:
<table>
	<tr><td>Research</td><td>3 hours</td></tr>
	<tr><td>Functionality</td><td>4 hours</td></tr>
	<tr><td>Layout/Styling</td><td>2 hour</td></tr>
	<tr><td>Deployment</td><td>1.5 hours</td></tr>
	<tr><td><b>Total</b></td><td>10.5 hours</td></tr>
</table>

[Running on Heroku](http://siidetest.heroku.com/index)
