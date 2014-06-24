/* 
	User Handler
*/

component name="UserHandler" extends="coldbox.system.EventHandler" {

	// Coldbox ORM EntityService Injection
	property name="UserService" inject="entityService:User";		// inject user entity
	
	
	/***********************************************/
	// Edit User
	/***********************************************/
	public void function EditUser(event, rc, prc) {
		rc.user = UserService.Get(rc.uid);
		//writedump(rc.user); abort;
		Event.setView("user/vwAddEditUser");
	}
	
	
	/***********************************************/
	// CreateUser
	/***********************************************/
	public void function CreateUser(event, rc, prc) {
		Event.setView("user/vwAddEditUser");
	}

	
	/***********************************************/
	// save user - used for both Add/Edit (http post)
	/***********************************************/
	function SaveUser(event, rc, prc) {
		//writedump(rc); abort;
		
		if (NOT structKeyExists(rc, "UserID"))
			var user = UserService.new();
		else
			var user = UserService.Get(rc.UserID);
		
		user.setEmail(rc.Email);
		user.setPassword(rc.Password);
		user.setFirstName(rc.FirstName);
		user.setLastName(rc.LastName);
		user.setNickname(rc.Nickname);
		user.setAvatar(rc.Avatar);
		//writedump(user); abort;
		
		// are we valid?
		prc.validationResults = validateModel( user );
		
		if (prc.validationResults.hasErrors()){
			// put form results back into request context
			rc.user = user;
			
			// redirect back to view
			Event.setView("user/vwAddEditUser");
		} 
		else 
		{
			//upload file
			getPlugin("FileUtils").uploadFile(fileField="AvatarImage", destination=expandPath('includes/images/avatar'));//, accept="image/jpg,image/png,image/gif");
			
			// Save user to database
			userService.save(user);

			// relocate back to index and persist username and password
			prc.user = user;
			setNextEvent(event="LoginHandler.doLogin", persist="Email,Password");
		}
	}
	
	
	
}