<div id="FizzleView"></div>
<div id="CommentView"></div>
<div id="pager" class="comment"></div>
<input type="hidden" id="currentUser" value="<cfoutput>#SessionStorage.getVar('UserID')#</cfoutput>" />

<!--- new comments --->
<br />
<cfif sessionstorage.getVar("loggedin", false)>
	<form id="commentForm" method="post">
		<textarea rows="3" cols="150" name="CommentText" id="CommentText"></textarea>
		<label class="error" for="CommentText" id="commentError">Comment is required</label>
		<br />
		<a id="iconSubmitButton">Submit Comment Icon</a>
	</form>
</cfif>



<!-- Kendo UI Template - Fizzle -->
<script type="text/x-kendo-template" id="FizzleViewTemplate">
	<div class="row">
		<div class="col-md-2">
			<h4>#: User.Nickname #</h4>
			<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>includes/images/avatar/#: User.Avatar #" alt="" width="100px" />
		</div>
		<div class="col-md-9">
			<h4>#: Subject #</h4>
			<p>#: Body #</p>
		</div>
	</div>
</script>



<!-- Kendo UI Template - Comments -->
<script type="text/x-kendo-template" id="CommentViewTemplate">
	<div id="CommentItem">
		<div class="row">
			<div class="col-md-2">
    			<h4>#: User.Nickname #</h4>
				<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>includes/images/avatar/#: User.Avatar #" alt="" width="100px" />
    		</div>
			<div class="col-md-7">
				<p>#: CommentText #</p>
			</div>
			<div class="col-md-1">
				# var userid = GetCurrentUserID() #
				# if (User.UserID == userid) { #
					<button class="k-button" onClick="DeleteComment(#: CommentID #)")>Delete <span class="k-icon k-group-delete">&nbsp;</span></button>
				# }	#
			</div>
		</div>
	</div>
</script>

<script>
	// this method will return the current logged in userID
	function GetCurrentUserID() {
		return $('#currentUser').val();
	}
	
	// this method will delete a comment given its ID
	function DeleteComment(id) {
		$.ajax({
			type: "POST",
			url: "index.cfm/KendoBootstrapHandler/DeleteComment",
			data: { 
				commentid: id },
			success: function() {
				location.reload();
			},
			error: function(jqXHR, exception) {
				console.log("Comment failed to delete: " + jqXHR.responseText);
			}
		});
	}


	// DOM Ready?
	$( document ).ready(function() {
		// form validation
		$('.error').hide();
		
		// comment submit button
		$("#iconSubmitButton").kendoButton({
            icon: "plus"
        }).click(function() {
			// for validation
			var comment = $("textarea#CommentText").val();
	    	if (comment == "") {
	    		$("label#commentError.error").show();
	      		$("textarea#CommentText").focus();
	      		return false;
	    	} else {
				$.ajax({
					type: "POST",
					url: "index.cfm/KendoBootstrapHandler/AddComment",
					data: { 
						postid: getParameterByName('postid'), 
						commenttext: comment },
					success: function() {
						location.reload();
					},
					error: function(jqXHR, exception) {
						console.log("Comment failed to add: " + jqXHR.responseText);
					}
				});
			}
		});
		
		// declare kendo datasource to hold individual fizzle
		var remoteDataSource = new kendo.data.DataSource({
	    	transport: {
	        	read: {
					url: "index.cfm/KendoBootstrapHandler/GetPostJSON",
					dataType: "json",	// required if JSON is being passed to us, else it thinks its a string
					data: {
						q: function() {
							// send parameter by returning it from a function
							return getParameterByName('postid')
						}
					}
				}
	    	}
	    });
		/* DEBUGGING 
		remoteDataSource.fetch(function() {
  			//console.log("here");
			var view = remoteDataSource.view();
  			console.log(view.length);	
  			console.log(view[0].User.Email);
		});		*/
		
		// fetch datasource (individual fizzle) so we can work with it
		remoteDataSource.fetch(function() {
			// get handle on datasource view
			var view = remoteDataSource.view();
			//console.log(JSON.stringify(view[0].Comment));
			
			// declare Fizzle view
			$("#FizzleView").kendoListView({
	    		dataSource: view,
				template: $("#FizzleViewTemplate").html()
			});

			// create a new datasource for just the comments
			//console.log(view[0].Comment.toJSON());
			var commmentDataSource = new kendo.data.DataSource({
		        data: view[0].Comment.toJSON(),
		        pageSize: 2
		    });
			/* DEBUGGING  
			commmentDataSource.fetch(function() {
  				//console.log("here");
				var view = commmentDataSource.view();
  				//console.log(view);	
  				//console.log(view.length);	
  				//console.log(User.Nickname);
			}); */

			// setup paging
			$("#pager").kendoPager({
		    	dataSource: commmentDataSource
		    });
			
			// declare Comment view
			$("#CommentView").kendoListView({
				dataSource: commmentDataSource,
				template: $("#CommentViewTemplate").html()
				//dataBound: function(e) {
				//	// could have also done this in the template and given a k-class to the button control
				//	$("#deleteComment").kendoButton({
            	//		icon: "close"
        		//	});
				//	//.click(function() {
				//	//	console.log("delete comment");	
				//	//});	
				//}
			});

			/*
			$("#deleteComment").kendoButton({
            	icon: "plus"
        	}).click(function() {
				console.log("delete");
			});
			*/
			
		});
		
		/*
		remoteDataSource.read();
		// declare Fizzle view
		$("#FizzleView").kendoListView({
    		dataSource: remoteDataSource,
			template: $("#FizzleViewTemplate").html()
		});
		// declare Comment view
		$("#CommentView").kendoListView({
			dataSource: remoteDataSource,
			template: $("CommentViewTemplate").html()
		})
		*/
				
	});
	
	// helper function to get query string parameter
	function getParameterByName(name) {
    	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        	results = regex.exec(location.search);
    	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	} 	
</script>
