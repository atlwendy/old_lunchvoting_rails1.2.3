class User < ActiveRecord::Base
    has_many :votes
    
    def remaining_votes(group)
        10 - Vote.count_by_sql(
                ["""select sum(preference) from votes 
                    where user_id = ? and group_id = ? and 
                    created_at = CURDATE()
                """, self.id, group.id])
    end
end
