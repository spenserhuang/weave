current_date  = Date.today.to_s.split('')
current_year  = current_date[0] + current_date[1] + current_date[2] + current_date[3]
current_month = current_date[5] + current_date[6]
current_day   = current_date[8] + current_date[9]
current_year = current_year.to_i
current_month = current_month.to_i
current_day = current_day.to_i
current_date_value = "#{current_month}/#{current_day}/#{current_year}"

get '/calendars/home' do
  @month_calendar = Calendar.where(year_number: current_year, month_of_year: current_month)
  @start_of_month = @month_calendar.first.name_of_day
  erb :'/calendars/home'
end

get '/calendars/current_year' do
  @year_calendar = Calendar.where(year_number: current_year)
  erb :'/calendars/year_view'
end

get '/calendars/current_month' do
  @month_calendar = Calendar.where(year_number: current_year, month_of_year: current_month)
  @start_of_month = @month_calendar.first.name_of_day
  erb :'/calendars/home'
end

get '/calendars/current_week' do
  @week_calendar_list = []
  @day = Calendar.find_by(date_value: current_date_value)
  current_day_id = @day.id
  @week_calendar_list << Calendar.find(current_day_id - 6)
  @week_calendar_list << Calendar.find(current_day_id - 5)
  @week_calendar_list << Calendar.find(current_day_id - 4)
  @week_calendar_list << Calendar.find(current_day_id - 3)
  @week_calendar_list << Calendar.find(current_day_id - 2)
  @week_calendar_list << Calendar.find(current_day_id - 1)
  @week_calendar_list << @day
  @week_calendar_list << Calendar.find(current_day_id + 1)
  @week_calendar_list << Calendar.find(current_day_id + 2)
  @week_calendar_list << Calendar.find(current_day_id + 3)
  @week_calendar_list << Calendar.find(current_day_id + 4)
  @week_calendar_list << Calendar.find(current_day_id + 5)
  @week_calendar_list << Calendar.find(current_day_id + 6)
  erb :'/calendars/week_view'
end

get '/calendars/current_five_day' do
  @current_day = Calendar.find_by(date_value: current_date_value)
  current_day_id = @current_day.id
  @five_day_list = []
  @five_day_list << @current_day
  @five_day_list << Calendar.find(current_day_id + 1)
  @five_day_list << Calendar.find(current_day_id + 2)
  @five_day_list << Calendar.find(current_day_id + 3)
  @five_day_list << Calendar.find(current_day_id + 4)
  erb :'/calendars/five_day_view'
end

get '/calendars/current_day' do
  @single_day = Calendar.where(year_number: current_year, month_of_year: current_month, day_of_month: current_day)
  erb :'/calendars/day_view'
end

post '/calendars/choose_date' do
  @chosen_date = params[:event_date_value]
  @chosen_year  = @chosen_date[0] + @chosen_date[1] + @chosen_date[2] + @chosen_date[3]
  @chosen_month = @chosen_date[5] + @chosen_date[6]
  @chosen_day   = @chosen_date[8] + @chosen_date[9]
  @chosen_date_value = "#{@chosen_month.to_i}/#{@chosen_day.to_i}/#{@chosen_year.to_i}"
  session[:chosen_date] = Calendar.find_by(date_value: @chosen_date_value)
  redirect '/calendars/chosen_month'
end

get '/calendars/chosen_year' do
  @year_calendar = Calendar.where(year_number: session[:chosen_date].year_number)
  erb :'/calendars/year_view'
end

get '/calendars/chosen_month' do
  @month_calendar = Calendar.where(year_number: session[:chosen_date].year_number, month_of_year: session[:chosen_date].month_of_year)
  @start_of_month = @month_calendar.first.name_of_day
  erb :'/calendars/home'
end

get '/calendars/chosen_week' do
  @week_calendar_list = []
  @day = session[:chosen_date]
  chosen_day_id = session[:chosen_date].id
  @week_calendar_list << Calendar.find(chosen_day_id - 6)
  @week_calendar_list << Calendar.find(chosen_day_id - 5)
  @week_calendar_list << Calendar.find(chosen_day_id - 4)
  @week_calendar_list << Calendar.find(chosen_day_id - 3)
  @week_calendar_list << Calendar.find(chosen_day_id - 2)
  @week_calendar_list << Calendar.find(chosen_day_id - 1)
  @week_calendar_list << @day
  @week_calendar_list << Calendar.find(chosen_day_id + 1)
  @week_calendar_list << Calendar.find(chosen_day_id + 2)
  @week_calendar_list << Calendar.find(chosen_day_id + 3)
  @week_calendar_list << Calendar.find(chosen_day_id + 4)
  @week_calendar_list << Calendar.find(chosen_day_id + 5)
  @week_calendar_list << Calendar.find(chosen_day_id + 6)
  erb :'/calendars/week_view'
end

get '/calendars/chosen_five_day' do
  chosen_day_id = session[:chosen_date].id
  @five_day_list = []
  @five_day_list << session[:chosen_date]
  @five_day_list << Calendar.find(chosen_day_id + 1)
  @five_day_list << Calendar.find(chosen_day_id + 2)
  @five_day_list << Calendar.find(chosen_day_id + 3)
  @five_day_list << Calendar.find(chosen_day_id + 4)
  erb :'/calendars/five_day_view'
end

get '/calendars/chosen_day' do
  @single_day = Calendar.where(year_number: session[:chosen_date].year_number, month_of_year: session[:chosen_date].month_of_year, day_of_month: session[:chosen_date].day_of_month)
  erb :'/calendars/day_view'
end

get '/calendars/:id' do
  @single_day = Calendar.where(id: params[:id])
  erb :'/calendars/day_view'
end