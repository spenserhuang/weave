get '/events/new' do
  erb :'/events/new_event_form'
end

post '/events' do
  desired_event_date = params[:event_date_value].split('')
  desired_event_year  = desired_event_date[0] + desired_event_date[1] + desired_event_date[2] + desired_event_date[3]
  desired_event_month = desired_event_date[5] + desired_event_date[6]
  desired_event_day   = desired_event_date[8] + desired_event_date[9]
  desired_event_date_reformat = "#{desired_event_month.to_i}/#{desired_event_day.to_i}/#{desired_event_year.to_i}"

  event = Event.new(
    title:            params[:title],
    description:      params[:description],
    event_street:     params[:event_street],
    event_city:       params[:event_city],
    event_state:      params[:event_state],
    event_zip_code:   params[:event_zip_code],
    event_country:    params[:event_country],
    event_type:       params[:event_type],
    event_date_value: desired_event_date_reformat,
    event_time_value: params[:event_time_value]
  )

  event.users << current_user
  event.calendars << Calendar.find_by(date_value: desired_event_date_reformat)

  if event.save!
    redirect "/calendars/home"
  else
    redirect '/events/new'
  end
end

get '/events/:id/edit' do
  @edit_event = Event.find(params[:id])
  erb :'/events/edit_event'
end

put '/events/:id' do
  edit_event = Event.find(params[:id])

  desired_event_date = params[:event_date_value].split('')
  desired_event_year  = desired_event_date[0] + desired_event_date[1] + desired_event_date[2] + desired_event_date[3]
  desired_event_month = desired_event_date[5] + desired_event_date[6]
  desired_event_day   = desired_event_date[8] + desired_event_date[9]
  desired_event_date_reformat = "#{desired_event_month.to_i}/#{desired_event_day.to_i}/#{desired_event_year.to_i}"

  edit_event.update_attributes(
    title:            params[:title],
    description:      params[:description],
    event_street:     params[:event_street],
    event_city:       params[:event_city],
    event_state:      params[:event_state],
    event_zip_code:   params[:event_zip_code],
    event_country:    params[:event_country],
    event_type:       params[:event_type],
    event_date_value: desired_event_date_reformat,
    event_time_value: params[:event_time_value]
  )

  redirect '/calendars/home'
end

delete '/events/:id' do
  @event = Event.find(params[:id])
  @event.destroy
  redirect '/calendars/home'
end

get '/events/:id' do
  @event = Event.find(params[:id])
  @event_location = "#{@event.event_street.to_s.strip}+#{@event.event_city.to_s.strip}+#{@event.event_state.to_s.strip}+#{@event.event_zip_code.to_s.strip}+#{@event.event_country.to_s.strip}"
  @event_location = @event_location.gsub(" ", "+" )
  erb :'/events/event_page'
end
