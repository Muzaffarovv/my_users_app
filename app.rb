require 'sinatra'
require_relative 'my_user_model.rb'

set :bind, '0.0.0.0'
set :port, '8080'
enable :sessions 

get '/users' do
    user = User.new()
    @users = user.all()
    erb :index
    # return users.to_json
end

post '/users' do
    user = User.new()
    user_info = [params['firstname'], params['lastname'], params['age'], params['password'], params['email']]
    id = user.create(user_info)
    "sacces a user id = #{id}"
end

post '/sign_in' do
    user = User.new()
    id = user.match(params['email'], params['password'])
    session[:user_id] = id[0][0]
    "User logged in with id #{id[0][0]}"
end

put '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.update(id, 'password', params['password'])
        "succes updated user"
    else
        "not autorizayshan"
    end
end

delete '/sign_out' do
    user = User.new()
    id = session[:user_id]
    if id
       session.delete('user_id')
    else
        "not autorizayshan"
    end
end

delete '/users' do
    user = User.new()
    id = session[:user_id]
    if id
        user.destroy(id)
        session.delete('user_id')
    else
        "not autorizayshan"
    end
end