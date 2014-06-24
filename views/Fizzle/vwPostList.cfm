<cfoutput>
	<cfloop array="#rc.PostArray#" index="post">
		<div class="row">
  			<div class="span2">
  				#post.getUser().getNickname()#
  				<br />
				<img src="#getSetting( 'htmlBaseURL' )#includes/images/avatar/#post.getUser().getAvatar()#" alt="" width="100px" />
  			</div>
  			<div class="span7">
				<h3><a href="#Event.BuildLink('FizHandler.PostView')#?postid=#post.getPostID()#">#post.getSubject()#</a></h3>
				#post.getBody()#
				<br />
				<a href="#Event.BuildLink('FizHandler.AddComment')#?postid=#post.getPostID()#">Add Comment</a>
			</div>
		</div>
		<br />
	</cfloop>
</cfoutput>