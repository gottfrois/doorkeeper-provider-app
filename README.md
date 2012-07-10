# Rails Sample Api

Here you will find a rails api demo using [Doorkeeper](https://github.com/applicake/doorkeeper/)
and [Mongoid 2.x.x](http://two.mongoid.org/).

Please see [Doorkeeper](https://github.com/applicake/doorkeeper/) for documentation on doorkeeper.

I used Ryan Bates [railscast #353](http://railscasts.com/episodes/353-oauth-with-doorkeeper) to
build this application. Some updates had been made to make it work with mongoid.

## Getting started

Just clone the repository and launch the `bundle` command:

    git clone git://github.com/gottfrois/rails-sample-api.git
    cd rails-sample-api
    bundle

Then start all services using [foreman](http://rubygems.org/gems/foreman)

    foreman start

or manually

    mongod run --config /usr/local/etc/mongod.conf
    bundle exec rails s

## Tips

If you want to use this for registering a mobile client for example, you might want
to skip the "authorize application" process. This way you won't have to ask your client
to authorize on the server with a web browser. You will just get your token from
the api server.

You can simulate a client using `curl`:

    curl -i http://localhost:3000/oauth/token \
    -F grant_type="client_credentials" \
    -F client_id="your_application_id" \
    -F client_secret="your_secret"

or using classic credentials:

    curl -i http://localhost:3000/oauth/token \
    -F grant_type="password" \
    -F username="your_username" \
    -F password="your_password"
