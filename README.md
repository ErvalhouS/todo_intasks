# TODO inTasks

Just another TODO list. You know what you have to do, just write that stuff down and organize yourself through a list of scheduled chores. Try to do most of it, just don't get paranoid about it - work for a living, don't live to work.

# Usage for dummies

[Access the application](http://todointasks.herokuapp.com), you will need an login to use it, click on the signup link and follow the registration instructions. Confirm your e-mail and come back to login into **TODO inTasks**. Start making your way into an organized way of life by creating tasks and putting a clock on them.

### Hack your friends' tasks
If you're reading this it means you have what it takes to HACK your friends' tasks with an Admin access into the system. Just use the following credentials to have full control of all tasks in the application. Just [access the administrative interface of the application](http://todointasks.herokuapp.com/admin) using those credentials:
```ruby
# E-mail
administr@tive.login
# Password
H4ckUrT@sk!
```

# Developing

You can download this application source code by [cloning this repository into your machine](https://help.github.com/en/articles/cloning-a-repository).
If you think you can take this application even further you need to have Rails `~> 5.2` installed. If you are unsure how to do that [checkout the Rails' documentation](https://guides.rubyonrails.org/v5.2/getting_started.html). The app has some requirements, which are:
  - [PostgreSQL](http://www.postgresqltutorial.com/install-postgresql/)
  - Your Brain(Hopefully you won't need to install this)

Beyond that, before running anything locally you need to setup the database and install the required gems by running:
```shell
$ bundle install & rails db:create & rails db:migrate & rails db:seed
```

To make sure something your code changes hasn't breaked most of the stuff in the application, run:
```shell
$ bundle exec rspec
```

After you have done your incredible job and you think it's time to get the application running in a browser, execute it:
```shell
$ rails server
```
-------
###### Move fast ~~and break things~~ with stable infra. Take pride on fixing things.
