class Restaurant < ActiveRecord::Base
	has_many :votes
	
	def vote_by_user_today(user, group)
	   Vote.find(:first, :conditions => 
	        ["""user_id = ? 
	        and group_id = ?
	        and restaurant_id = ?
	        and created_at = CURDATE()
	        """, user.id, group.id, self.id])
	end
	
	def Restaurant.vote_counts(group)
	    Restaurant.find_by_sql(["""
    	    select 
                   sum(votes.preference) as vote_count, 
                   restaurants.id as id,
                   restaurants.name as name
            from restaurants left outer join 
                (select * from votes where created_at = CURDATE() and group_id = ?) votes 
                on (restaurants.id = votes.restaurant_id) 
            where 
                restaurants.group_id = ? 
            group by restaurants.id, restaurants.name
            order by vote_count desc
    	""", group.id, group.id])
	end
	
	def votes_so_far(group)
	    Vote.count_by_sql(["""
            select sum(preference) preference 
            from votes
            where 
                votes.restaurant_id = ? and 
                votes.group_id = ? 
            and votes.created_at = CURDATE() 
        """, self.id, group.id])
	end
end
