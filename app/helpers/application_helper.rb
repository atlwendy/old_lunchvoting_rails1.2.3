# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def root
        RAILS_ENV == 'production' ? '/lunchvoting' : ''
    end
end
