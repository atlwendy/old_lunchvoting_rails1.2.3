class VoteController < ApplicationController
    layout "outline"
    def index
      redirect_to :action => 'list'
    end

    def new
     @vote = Vote.new
    end

    def create
        vp = params['vote']
        @dup = Vote.find_duplicate(vp['restaurant_id'], vp['user_id'], vp['group_id'])
        if @dup != nil then
            @dup.destroy
        end
        @vote = Vote.new(vp)
        @vote.save!
        sum = @vote.restaurant.votes_so_far(@vote.group)
        remaining = @vote.user.remaining_votes(@vote.group)
        render(:text => {
            :count => sum.to_s, 
            :left => remaining.to_s, 
            :preference => @vote.preference.to_s
        }.to_json)

    end
    
    def veto
        vt = params['vote']
        @veto = Vote.new(vt)
        @veto.save!
        remaining_veto = @veto.user.remaining_vetoes(@veto.group)
        render(:vetoleft => remaining_veto)
    end

    def list
      @title = "All Votes"
      @group_id = session[:group_id]
      @group_name = (Group.find(session[:group_id])).name
      @votes_by_restaurant = Vote.find_by_sql([
      'select SUM(preference) preference, restaurants.name name, count(*) vote_count from votes, restaurants 
        where votes.restaurant_id = restaurants.id and votes.group_id=? and votes.created_at = CURDATE() group by restaurant_id order by preference desc
        ', @group_id])
      
      @restaurants = Restaurant.find_by_sql 'select restaurants.name, restaurants.id from votes, restaurants where votes.restaurant_id = restaurants.id and votes.created_at = CURDATE() GROUP by restaurant_id'
      @votes = Vote.find :all
    end
    
    def tally
      @results = Restaurant.find_by_sql 'select sum(preference) vote_count, restaurants.name from votes, restaurants where votes.restaurant_id = restaurants.id and votes.created_at = CURDATE() GROUP by restaurant_id'
    end
    
    def getname
	@title = "Name Input"
        if request.post?
            user = User.new({'emailaddress' => params['person_name']})
            user.save
            if params['group_name'] && (not params['group_name'].empty?) then
                group = Group.new({'name' => params['group_name']})
                group.save                        
#                session[:group_name] = group.name
                session[:group_id] = (Group.find_by_name(group.name)).id
            end
            session[:emailaddress] = user.emailaddress            
            @user_emailaddress = user.emailaddress
            session[:user_id] = user.id
            logger.info session[:group_id]
 #           person_name = session[:person_name]
            redirect_to({:controller => 'restaurant', :action => 'listandvote'})
        end
    end
    
    def vote
	@title = "Vote"
        if not session[:emailaddress] then
            redirect_to :action => 'getname'
        else
            @vote.group_id = group_id = session[:group_id]
            @vote = Vote.new params['vote']
            if request.post?
                @vote.save
            end
            emailaddress = session[:emailaddress]
            #@vote.user_id = user_id = (Users.find(emailaddress)).id
            @vote.user_id = user_id = session[:user_id]
            @votes = Vote.find :all, :conditions => ['user_id = ? and group_id = ?', user_id,group_id]
            @remaining_votes = 10 - Vote.count_by_sql(
                ['select sum(preference) from votes where user_id = ? and group_id = ? and votes.created_at = CURDATE()', user_id, group_id])
        end
    end
    

end
