# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
# get '/signup', to: 'users#new'
post '/sign_up', to: 'users#create'
delete '/users/:id', to: 'users#destroy'

post '/sign_in', to: 'accounts#sign_in'
#post '/sign_out', to: 'accounts#sign_out'

get '/videos', to: 'videos#index'
post '/videos', to: 'videos#create'
patch '/videos/:id', to: 'videos#update'
delete '/videos/:id', to: 'videos#destroy'
get '/videos/search', to: 'videos#search'
