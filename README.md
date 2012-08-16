# Doorkeeper Provider App

Here you will find a [Doorkeeper](https://github.com/applicake/doorkeeper/) Provder demo using [Devise](https://github.com/plataformatec/devise/)
and [Mongoid 2.4.x](http://two.mongoid.org/).

Please see [Doorkeeper](https://github.com/applicake/doorkeeper/) for documentation on doorkeeper.

Please see [OAuth2](https://github.com/intridea/oauth2/) for documentation on OAuth2 and to understand the requests calls below.

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

    bundle exec rake db:seed

This will create two users you can use to play with the application:

    email: "john.smith@myapp.com", password: "please"
    email: "lee.do@myappcom", password: "please"

You are good to visit http://localhost:5100 and enjoy :)

## API

This app provide basic API calls. The current API endpoints are:

    GET /api/conversations
    GET /api/conversations/:id
    GET /api/conversations/:conversation_id/messages
    GET /api/conversations/:conversation_id/messages/:id
    GET /api/users
    GET /api/users/me
    POST /api/users
    POST /api/conversations
    PUT /api/conversations/:conversation_id/messages/:id
    DELETE /api/conversations/:conversation_id/messages/:id

See routes file for more details.

All API controllers are under "app/controllers/api/v1/". Just create a new folder (namespace) to build a new API version.

See below how to make api call in rails console.

## Manage applications

Run the server and go to `http://localhost:5100/oauth/applications` to see and manage authorized applications.

## Tips

If you want to use this for registering a mobile client for example, you might want
to skip the "authorize application" process. This way you won't have to ask your client
to authorize on the server with a web browser. You will just get your token from
the api server.

You can simulate a client using `curl`:

    curl -i http://localhost:5100/oauth/token \
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

	irb -r oauth2

Then in the console:

    app_id = "your_app_id"
    secret = "your_secret"
    client = OAuth2::Client.new(app_id, secret, site: "http://localhost:5100")
    access = OAuth2::AccessToken.from_hash(client, {"access_token" => "the_token_returned_from_curl_command","token_type" => "bearer","expires_in" => 7200})
    
    access.get('/api/users').parsed
    access.get('/api/users/me').parsed
    access.get('/api/conversations').parsed
    access.get('/api/conversations/some_id/').parsed
    access.get('/api/conversations/some_id/messages').parsed
    
    access.post('/api/users', body: {user: {email: 'foo@bar.com', password: 'please'}}).parsed
    access.post('/api/conversations', body: {conversation: {messages_attributes: [{body: 'foo'}]}}).parsed
    
    access.put('/api/conversations/5022caba1de760379b000003/messages/5022caba1de760379b000004', body: {message: {body: 'new content'}}).parsed
    
    access.delete('/api/conversations/5022caba1de760379b000003/messages/5022caba1de760379b000004').parsed


Note: When making the POST request on `/api/users`, you'll probable want to do it without a token you've got from curl passing some user's credentials. In another word, my example is made such that you can create a new user from an API call passing a valid token, but a token acquired without some user's credentials. Like the curl command we saw previously:

	curl -i http://localhost:5100/oauth/token \
    -F grant_type="client_credentials" \
    -F client_id="your_application_id" \
    -F client_secret="your_secret"
    
Then you could get a brand new token (and use this one for further requests if you want change the "current_user" context to your new user) acquired this time with your new user's credentials.

### Note on CORS (Cross Origin Resource Sharing)

You might be cronfronted to some issues while requesting for an other domain (from a mobile application for example).

For this demo application, I have used [rack-cors](https://github.com/cyu/rack-cors) middleware in order to set HTTP headers to allow [CORS](http://www.nczonline.net/blog/2010/05/25/cross-domain-ajax-with-cross-origin-resource-sharing/).

That's it for now !
