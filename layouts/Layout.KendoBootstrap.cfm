<cfset sessionstorage = getPlugin("SessionStorage")>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Fizzle my Nizzle</title>
	<base href="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>" />
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="includes/styles/kendo.common.min.css" />
	<link rel="stylesheet" href="includes/styles/kendo.bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="includes/styles/fizzleKendoBootstrap.css">
	
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>    
	<script src="includes/javascript/kendo.all.min.js"></script> 

</head>
<body>
    <header>
		<div class="container">
        	<div class="row">
  				<div class="col-md-9"><h3 class="TitleImage">Fizzle my Kendo Bootstrap</h3></div>
  				<div class="col-md-3">
  					<div class="HeaderWelcome">
						<cfoutput>
						<cfif sessionstorage.getVar("loggedin", false)>
							<!--- we're logged in --->
							Welcome <a href="#Event.BuildLink('UserHandler.EditUser')#?uid=#SessionStorage.getVar("UserID")#">#SessionStorage.getVar("name")#</a>!
							<a href="index.cfm/#Event.getValue("xehLogout")#">Logout</a>
						<cfelse>
							<!--- not logged in --->
							<a href="index.cfm/LoginHandler/Login">Login</a>
						</cfif>
						</cfoutput>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<!-- Navigation Menu -->
		    		<ul class="nav nav-tabs">  
						<li><a href="<cfoutput>#Event.BuildLink('FizHandler.PostList')#</cfoutput>">Fizzle Home</a></li>  
				  		<li><a href="<cfoutput>#Event.BuildLink('PlaygroundHandler.Playground')#</cfoutput>">Playground</a></li>  
				  		<li class="active"><a href="<cfoutput>#Event.BuildLink('KendoBootstrapHandler.PostList')#</cfoutput>">Fizzle Kendo Bootstrap</a></li>
						<li><a href="<cfoutput>#Event.BuildLink('KendoBootstrapHandler.PostViewSplitter')#</cfoutput>?postid=3">Fizzle View Splitter</a></li>
						<li><a href="<cfoutput>#Event.BuildLink('UserHandler.EditUser')#?uid=#SessionStorage.getVar("UserID")#</cfoutput>">My Account</a></li>  
					</ul>
				</div>  
			</div>
		</div>
	</header>	
	
	<section id="MainContent">
		<div class="container">
			<div class="row">
				<div class="col-md-2">
				    <div class="sidebar1">
				      	<cfif sessionstorage.getVar("loggedin", false)>
							<br />
							<h3><cfoutput>#SessionStorage.getVar("name")#</cfoutput></h3>
							<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#includes/images/avatar/#SessionStorage.getVar('Avatar')#</cfoutput>" alt="" width="100px" />
							<br />
							<a href="<cfoutput>#Event.BuildLink('UserHandler.EditUser')#?uid=#SessionStorage.getVar("UserID")#</cfoutput>">Edit Account</a>
						  </cfif>
				    </div>			
				</div>
				<div class="col-md-10">
				    <div class="content">
				    	<br />
				    	<cfoutput>#renderView()#</cfoutput>
				    </div>
				</div>
			</div>
		</div>
	</section>
	
	<footer>
		Copyright &copy; 2014 Mentis Consulting Group. All Rights Reserved.
	</footer>
</body>
</html>
