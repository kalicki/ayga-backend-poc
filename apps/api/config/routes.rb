# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
# get '/signup', to: 'users#new'
post '/signup', to: 'users#create'
delete '/users/:id', to: 'users#destroy'

post '/signin', to: 'accounts#signin'
get '/signout', to: 'accounts#signout'

get '/videos', to: 'videos#index'
post '/videos', to: 'videos#create'
delete '/videos/:id', to: 'videos#destroy'
