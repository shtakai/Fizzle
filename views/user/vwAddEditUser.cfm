<!---
<cfdump var="#rc#" />
<cfdump var="#prc#" />	
--->

<cfoutput>
	<!--- Display all errors as a message box --->
	<cfif structKeyExists(prc, "validationResults")>
		<cfif prc.validationResults.hasErrors()>
			<ul>
				<cfloop array="#prc.validationResults.getErrors()#" index="thisError">
					<li>#thisError.getMessage()#</li>
				</cfloop>
			</ul>
		</cfif>
	</cfif>

	<form action="#Event.BuildLink('UserHandler.SaveUser')#" method="post" enctype="multipart/form-data">
	
		<table class="table">
			<tr>
				<td>Username/Email:</td>
				<td><input type="text" name="Email" value="<cfif structKeyExists(rc, "user")>#rc.user.getEmail()#</cfif>" /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="Password" value="<cfif structKeyExists(rc, "user")>#rc.user.getPassword()#</cfif>" /></td>
			</tr>
			<tr>
				<td>First Name:</td>
				<td><input type="text" name="FirstName" value="<cfif structKeyExists(rc, "user")>#rc.user.getFirstName()#</cfif>" /></td>
			</tr>
			<tr>
				<td>Last Name:</td>
				<td><input type="text" name="LastName" value="<cfif structKeyExists(rc, "user")>#rc.user.getLastName()#</cfif>" /></td>
			</tr>
			<tr>
				<td>Nickname:</td>
				<td><input type="text" name="Nickname" value="<cfif structKeyExists(rc, "user")>#rc.user.getNickname()#</cfif>" /></td>
			</tr>
			<tr>
				<td>Avatar:</td>
				<td>
					<div style="float:left;">
						<cfif structKeyExists(rc, "user")>
							<img src="#getSetting( 'htmlBaseURL' )#includes/images/avatar/#rc.user.getAvatar()#" alt="" height="100px" width="100px" />
						<cfelse>
							<img src="#getSetting( 'htmlBaseURL' )#includes/images/avatar/DefaultUser.png" alt="" height="100px" width="100px" />
						</cfif>
					</div>
					<div style="float:right;">
						Upload New Avatar:<br>
						<input type="file" name="AvatarImage" id="AvatarImage" />
						<input type="hidden" name="Avatar" id="Avatar" />
					</div>
				</td>
			</tr>
			<tr>
				<td colspan='2'>
					<cfif structKeyExists(rc, "user")>
						<input type="hidden" name="UserID" value="#rc.user.getUserID()#" />
						<input type="submit" name="btnSubmit" value="Edit" />
					<cfelse>
						<input type="submit" name="btnSubmit" value="Save" />
					</cfif>
	    			
				</td>
			</tr>
	    </table>
    </form>
</cfoutput>

<script language="JavaScript">
	$('#AvatarImage').change(function(){
		// duplicate image name to hidden textbox
		$('#Avatar').val( $('#AvatarImage').val().split('\\').pop() );
		
		/* resize image
		var filesToUpload = input.files;
		var file = filesToUpload[0];
		
		var img = document.createElement("img");
		var reader = new FileReader();  
		reader.onload = function(e) {img.src = e.target.result}
		reader.readAsDataURL(file);
		
		var ctx = canvas.getContext("2d");
		ctx.drawImage(img, 0, 0);
		
		var MAX_WIDTH = 100;
		var MAX_HEIGHT = 100;
		var width = img.width;
		var height = img.height;
		
		if (width > height) {
		  if (width > MAX_WIDTH) {
		    height *= MAX_WIDTH / width;
		    width = MAX_WIDTH;
		  }
		} else {
		  if (height > MAX_HEIGHT) {
		    width *= MAX_HEIGHT / height;
		    height = MAX_HEIGHT;
		  }
		}
		canvas.width = width;
		canvas.height = height;
		var ctx = canvas.getContext("2d");
		ctx.drawImage(img, 0, 0, width, height);
		
		var dataurl = canvas.toDataURL("image/png");
		console.log(dataurl);
		*/
	});
</script>

