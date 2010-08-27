class Vote < ActiveRecord::Base
	belongs_to :restaurant
	belongs_to :user
	belongs_to :group
	
	def Vote.find_by_restaurant
		find_by_sql %Q|
			select restaurants.*, vote_count from restaurants, 
			       (select count(*) vote_count, restaurant_id 
			        from votes
			        where created_at = CURRENT_DATE
			        group by restaurant_id) votes
			where restaurants.id = votes.restaurant_id
		|
	end
	
	def Vote.find_duplicate(r, u, g)
	    Vote.find(:first, :conditions => ['restaurant_id = ? and user_id = ? and group_id = ?', r, u, g])
	end
	
	
    
end
