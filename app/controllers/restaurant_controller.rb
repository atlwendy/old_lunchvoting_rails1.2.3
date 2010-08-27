class RestaurantController < ApplicationController
    layout "outline"
    def new
     @vote = Vote.new params['vote']
     @restaurant = Restaurant.new
     @title = "Create a New Restaurant"
    end
    
    def create
     @restaurant = Restaurant.new(@params['restaurant'])
     @restaurant.group_id = session[:group_id]
     if @restaurant.save
#        redirect_to  :action => 'listandvote'
        render_action 'new'
     else
        render_action 'new'
     end
    end

    def delete
        @restaurant = Restaurant.find(@params['id']).destroy 
        redirect_to :action => 'listandvote'
    end

    
    def list
        @title = "List of All Restaurants"
        @restaurants = Restaurant.find_all
    end
    
    def listandvote
        if not session[:user_id] then
            if @params['hash'] then
                mapping = Usergroupmapping.find :first, :conditions => ['hash = ?', @params['hash']]
                user = User.find_by_emailaddress(mapping.emailaddress)
                session[:user_id] = user.id
                session[:group_id] = mapping.group_id
            else
                redirect_to(:controller => 'vote',:action => 'getname')
                return
            end
        end
        @user = User.find(session[:user_id])
        @group = Group.find(session[:group_id])
        @vote_counts = Restaurant.vote_counts(@group)
    end

end

