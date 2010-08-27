class LoginController < ApplicationController
    layout "outline"
    def login
        @no_menu = true
	    @title = "Group Name Input"
        if request.post?
#            session[:person_name] = params['person_name']
#            session[:group] = params['group']
#            session[:user_id] = user.id
#            g = Group.find_by_sql(['select * from groups where name = ?', params['group']])
#            if g == nil
#                group = Group.new({'name' => params['group']})
#                group.save
#            else
#                group = g
#            end
            group = Group.new({'name' => params['group']})
            group.save
#            groupid_obj = Group.find_by_sql(['select id from groups where name = ?', params['group']])
            group.reload
            session[:group_id] = group.id
            logger.info session[:group_id]
            redirect_to({:controller => 'login', :action => 'invitation'})
        end
    end
    
    def invitation
	require 'md5'
        @no_menu = true
        @title = "Invitation page"
        if session[:group_id] then
#            group = Group.find(session[:group_id])
#            group_name = Group.find_by_sql(['select name from groups where id = ?', session[:group_id]])
            group_name = (Group.find(session[:group_id])).name
        end
        if request.post?
#            user = User.new({'emailaddress' => params['emailaddress']})       
#            user.save
#            user.reload
    	    @params['emailaddress'].each do |address|
#    	        user = User.new({'emailaddress' => address})       
                user = User.new()
                user.emailaddress = address
                user.save
                user.reload
        	    @usergroupmapping = Usergroupmapping.new()
            	@usergroupmapping.emailaddress = address
        	    @usergroupmapping.group_id = session[:group_id]
        	    group_name = (Group.find(session[:group_id])).name
    		    hash = MD5.new(rand().to_s)
    		    @usergroupmapping.hash = hash.to_s
    	    	@usergroupmapping.save
    	    	#MyMailer.deliver_mail(address)
    	    	MyMailer.deliver_mail(address, group_name, hash)
        	    logger.info @usergroupmapping
    	    end
            logger.info @params['emailaddress']
            redirect_to({:controller => 'restaurant', :action => 'listandvote'})
        end
    end
    
    def email_sent
        MyMailer::deliver_mail("recipient.address@example.com")
    end
    
    def index
      redirect_to :action => 'login'
    end
end
