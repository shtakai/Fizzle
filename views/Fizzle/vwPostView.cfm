<cfoutput>
	<!--- Display all errors as a message box --->
	<cfif structKeyExists(rc, "commentValidationResults")>
		<cfif rc.commentValidationResults.hasErrors()>
			<ul>
				<cfloop array="#rc.commentValidationResults.getErrors()#" index="thisError">
					<li>#thisError.getMessage()#</li>
				</cfloop>
			</ul>
		</cfif>
	</cfif>

	<div class="post">
		<div class="row">
			<div class="span2">
				<img src="#getSetting( 'htmlBaseURL' )#includes/images/avatar/#rc.post.getUser().getAvatar()#" alt="" height="100px" width="100px" />
				<br />
				#rc.post.getUser().getNickname()#
			</div>
			<div class="span6">
				<h3>#rc.post.getSubject()#</h3>
				#rc.post.getBody()#
			</div>
		</div>
	</div>
	<cfloop array="#rc.CommentArray#" index="comment">
		<div class="comment">
			<div class="row">
				<div class="span2">
					<img src="#getSetting( 'htmlBaseURL' )#includes/images/avatar/#comment.GetUser().GetAvatar()#" alt="" height="100px" width="100px" />
					<br />
					#comment.GetUser().getNickname()#
				</div>
				<div class="span5">
					#comment.getCommentText()#
				</div>
				<div class="span1">
					<cfif SessionStorage.getVar("UserID") eq #comment.GetUser().GetUserID()#>
						<a href="#Event.BuildLink('FizHandler.DeleteComment')#?commentid=#comment.GetCommentID()#&postid=#rc.post.getPostID()#">Delete</a>
					</cfif>
				</div>
			</div>
		</div>
	</cfloop>
	
	<!--- new comments --->
	<cfif sessionstorage.getVar("loggedin", false)>
		<form action="#Event.BuildLink('FizHandler.AddComment')#?postid=#rc.Post.GetPostID()#" method="post">
			<textarea rows="3" cols="500" name="CommentText" id="CommentText">Enter your comment here</textarea>
			<input type="submit" />
		</form>
	</cfif>
</cfoutput>