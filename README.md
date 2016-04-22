# groupmates
Official repository of Groupmates project. Open source collaboration tool to enhance education and research.

## Requirements

- Docker: I recommend you to install the Docker Toolkit

## Setup



First of all, let's make sure Docker is ready.
```
# At the root of groupmates repo
docker-machine start
docker-machine ip  # Give you the ip
docker-machine env # If not done
```

Next, we need to build our Docker containers. Make sure the ip of the docker-machine match the ip in the configuration file: ***.env.dev*** .
```
docker-compose build
docker-compose up
# Server is running on http://<docker-machine ip>:3000/  
```
MySQL will be running, user is ***root***, password is ***root***, host is the ip of your docker-machine, port is 13306. Then we need to configure the database, since groupmates folder is now used as working directory for docker, just use:
```
rake db:create; rake db:setup;
```
The DB will get set up and populated with seed data. See db/demo_data_* files, the password for each user is ***password***.

That's it, happy coding!

If you have any issues, please report them. You can also contact me by email for questions (see below).

## How to contribute?

I invite you to try the [Demo](https://groupmates.co) and see what Groupmates look like now. Once you're done, please go to the [Features](https://github.com/Groupmates-co/groupmates/wiki/Features---Roadmap) page of the wiki to see what features are implemented and what is missing.
Then choose something you would like to be working on, setup the project on your machine, for the repository and start working on it :)

## More info

If you have any question, please email thomas@groupmates.co

Happy coding!
