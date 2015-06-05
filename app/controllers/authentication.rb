get '/sign_up/new' do
  erb :'/authentication/sign_up'
end

post '/sign_up' do
  user = User.new(params[:user])
  if user.save!
    session[:user_id] = user.id
    redirect "/calendars/home"
  else
    redirect "/sign_up"
  end
end

get '/sign_in/new' do
  erb :'/authentication/sign_in'
end

post '/sign_in' do
  user = User.find_by(username: params[:user][:username])
  if user && user.authenticate(params[:user][:password])
    session[:user_id] = user.id
    redirect "/calendars/home"
  else
    redirect "/sign_in/new"
  end
end

get '/sign_out' do
  session[:user_id] = nil
  erb :'/authentication/sign_out'
end

get '/auth/twitter/callback' do

  nickname = env['omniauth.auth']["info"][:nickname]

  user = User.find_by(username: nickname)

  if user
    p "here"
    session[:user_id] = user.id
    redirect '/calendars/home'
  else
    user = User.new(
      username:              env['omniauth.auth']["info"][:nickname],
      first_name:            env['omniauth.auth']["info"][:name].split(" ")[0],
      last_name:             env['omniauth.auth']["info"][:name].split(" ")[-1],
      password:              "123456",
      password_confirmation: "123456",
      phone_number:          "not set",
      email:                 "not set"
    )

    if user.save
      session[:user_id] = user.id
      redirect '/calendars/home'
    else
    redirect '/'
    end
  end
end

get '/auth/facebook/callback' do

  username = env['omniauth.auth']["info"][:name]

  user = User.find_by(username: username)

  if user
    session[:user_id] = user.id
    redirect '/calendars/home'
  else
    user = User.new(
      username:              env['omniauth.auth']["info"][:name],
      first_name:            env['omniauth.auth']["info"][:first_name],
      last_name:             env['omniauth.auth']["info"][:last_name],
      password:              "123456",
      password_confirmation: "123456",
      phone_number:          "not set",
      email:                 env['omniauth.auth']["info"][:email]
    )

    if user.save
      session[:user_id] = user.id
      redirect '/calendars/home'
    else
    redirect '/'
    end
  end
end
