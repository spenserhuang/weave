class Event < ActiveRecord::Base

  validates :title, :event_date_value, presence: true

  has_many :event_ownerships
  has_many :users, through: :event_ownerships

  has_many :event_dates
  has_many :calendars, through: :event_dates

end
