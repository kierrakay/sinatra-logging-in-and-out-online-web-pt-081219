require 'pry'
require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do

 @user = User.find_by(username: params[:username])
    if @user !=nil && @user.password == params[:password] #checks there password to see if it matches too 
      session[:user_id] = @user.id
      redirect to '/account'
    
    end
    erb :error
end

  get '/account' do
  @user = User.find_by(id: session[:user_id]) # to find use 

if @user# if it finds user this will be truthy and go to account user
    erb :account
    else # if it doesn't find user it will be nil and go to error page 
    erb :error
  end

    end



get '/logout' do
 session.clear
 redirect '/'
  end


end

