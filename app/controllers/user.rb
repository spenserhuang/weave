get '/users/profile'  do
  erb :'/users/profile'
end

get '/users/profile/edit' do
  erb :'/users/edit_profile'
end

put '/users/profile' do
  current_user.update_attributes(params[:user])
  redirect '/users/profile'
end