# Suppport Tickets Manager

[github](https://github.com/fedeaux/tickets-manager)

### Running Locally

Assuming you already have ruby and bundler installed.

     $ cd /path/to/project
     $ bundle install

Bundle should warn you about missing system packages, like mysql or QT, read the warns and follow the instructions.

Rename the .env.example file to .env, edit it according to your local requirements, and run

     $ rake db:create && rake db:create RAILS_ENV=test
     $ rake db:migrate && rake db:migrate RAILS_ENV=test

To create you local databases. And then run

     $ rails server

To start the server and go to http://localhost:3000 to view the app.

You may want to start with some data, to do so, run

    $ rake db:seed

It will create some users and some tickets. To know which users have been created, you can check via console.

    $ rails console
```ruby
> User.all
```

Every user is created with password 'defaultpassword', charles@ray.com and wonder@steve.com are customers and vaughn@ray.com is an admin. You can create new users through http://localhost:3000/users/sign_up or by the console.

    $ rails console

```ruby
> User.create email: 'someemail@example.com', password 'mypassword', password_confirmation: 'mypassword' # customer
> User.create email: 'someemail@example.com', password 'mypassword', password_confirmation: 'mypassword', role: 'admin' # admin
```

### Running Tests

    $ rspec spec

You may get warnings about missing system libraries. Since we are testing features with capybara-webkit you may be asked to install [QT](https://www.qt.io/).

To view a coverage report, open coverage/index.html. (Created with simplecov gem)

### Assumptions

* There are two kinds of users: Customers and Admins. They are differentiated by a column named "role". This column is protected on the controller level from malicious requests.

* Anyone (customers and admins) can create new support tickets, customers can add messages to their own tickets, while admins can add messages to any ticket, edit ticket info and promote/demote users from the admin role.

* Being real-time isn't a requirement, since I believe users don't really expect real-time answers. But a notification system would be nice if there was more time (or it was an actual system).

* The admin full-controll (i.e being able to manage everything) was not implemented. Aside from being a little boring, they don't really add real value to the purpose of this test (testing my coding skills)

* JS-enabled feature tests are enough to cover javascript within this kind of simple app.

* Requests specs are enough to test the controllers as a by-product. More complex apps would require controller specs as well.

* The challenge asked for bootstrap, but I'm assuming any css framework would do the trick, so I've used semantic-ui, which is way better :p

### About this test

Well, I believe I can be honest here: I think this kind of test is really boring.
You know, every job I've applied to ask for this kind of "very basic" test. They are not challenging, but demand a lot of time, and almost anyone could have done them and feel like I'm feeling: "I could do so much better...".

Also I have a lot of similar toy projects (with better ideas and design) that I not only could, but would love to show without spending time and with better results. I think giving the option for us to show any project would be nice.

If I were to apply this kind of test, I would give a basic (or even complex) system and ask for more challenging tasks like:
* The notification system implemented has grown organically and needs a refactor. Please refactor it in order to DRY it up and make it more modular.

* Make the message system real-time.

* There is leak of security on the "promote to admin" feature, allowing malicious requests to promote customers to admin. Find and correct it, writing specs that address this issue.

* Create one pull request for each one of these tasks at "some private github repo"
