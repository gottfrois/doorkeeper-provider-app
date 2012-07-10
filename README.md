# Doorkeeper Provider App

Here you will find a [Doorkeeper](https://github.com/applicake/doorkeeper/) Provder demo using [Devise](https://github.com/plataformatec/devise/)
and [Mongoid 2.4.x](http://two.mongoid.org/).

Please see [Doorkeeper](https://github.com/applicake/doorkeeper/) for documentation on doorkeeper.

I used Ryan Bates [railscast #353](http://railscasts.com/episodes/353-oauth-with-doorkeeper) to
build this application. Some updates had been made to make it work with mongoid.

## Getting started

Just clone the repository and launch the `bundle` command:

    git clone git://github.com/gottfrois/doorkeeper-provider-app.git
    cd doorkeeper-provider-app
    bundle

Then start all services using [foreman](http://rubygems.org/gems/foreman):

    foreman start

If `foreman` is not installed yet, you can either start services manually or install foreman with:

    gem install foreman

or manually start services:

    mongod run --config /usr/local/etc/mongod.conf
    bundle exec rails s -p 5100

Run the following rake command to seed the database:

    bundle exec rake db:drop
    bundle exec rake db:seed

You are good to visit http://localhost:5100 and enjoy :)

## API

This app provide a very basic API. The current API endpoints are:

    /api/messages
    /api/user

See the routes.rb file:

    require 'api_constraints'
    namespace :api, defaults: {format: 'json'} do
        scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
            resources :messages, only: [:index, :create]
            match 'user', to: 'users#show'
        end
    end

All the controllers are under "app/controllers/api/v1/"

## Manage applications

Run the server and go to `http://localhost:5100/oauth/applications`

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

You can use user credentials to get the token without validations:

    curl -i http://localhost:5100/oauth/token \
    -F grant_type="password" \
    -F username="a_user_email_address" \
    -F password="a_user_password" \
    -F client_id="your_application_id" \
    -F client_secret="your_secret"

You can use `irb` console to test:

    require "oauth2"
    app_id = "your_app_id"
    secret = "your_secret"
    client = OAuth2::Client.new(app_id, secret, site: "http://localhost:5100")
    access = OAuth2::AccessToken.from_hash(client, {"access_token" => "the_token_just_returned_from_the_previous_command","token_type" => "bearer","expires_in" => 7200})
    access.get('/api/user').parsed
