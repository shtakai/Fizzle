/*
	Fizzle Handler
*/

component name="FizHandler" extends="coldbox.system.EventHandler" {
	
	// ORM injection
	property name="PostService" inject="entityService:Post";
	property name="CommentService" inject="entityService:Comment";


	/***********************************************/
	// Post List
	/***********************************************/
	public void function PostList(event, rc, prc) {
		rc.PostArray = PostService.getAll();		
		// veiw
		Event.setView("Fizzle/vwPostList");
	}
	
	
	/***********************************************/
	// Post View
	/***********************************************/
	public void function PostView(event, rc, prc) {
		//writedump(rc); abort;
		
		// get post by post id
		rc.post = PostService.Get(rc.postid);
		
		// get comment array by post id
		rc.CommentArray = rc.post.GetComment();
		
		// view
		//Event.setView(view="Fizzle/vwPostView", args={postid=#rc.post.getPostID()#});
		Event.setView("Fizzle/vwPostView");
	}
	
	
	/***********************************************/
	// Add Comment
	/***********************************************/
	public void function AddComment(event, rc, prc) {
		//writedump(rc); abort;
		
		// populate and save new comment
		var comment = CommentService.New();
		comment.SetPostID(rc.postid);
		comment.SetUserID(getPlugin("SessionStorage").getVar("UserID"));
		comment.SetCommentText(rc.CommentText);
		
		// are we valid?
		rc.commentValidationResults = validateModel(comment);
		
		if (rc.commentValidationResults.hasErrors()){
			// we have errors, redirect back to view
			
			setNextEvent(event="FizHandler.PostView", persist="postid, commentValidationResults");
		} else {
			//writedump("NO error"); abort;
			CommentService.Save(comment);
		}
		
		// redirection
		setNextEvent(event="FizHandler.PostView", persist="postid");
	}
	
	
	/***********************************************/
	// Add Comment
	/***********************************************/
	public void function DeleteComment(event, rc, prc) {
		var comment = CommentService.Get(rc.commentid);
		CommentService.Delete(comment);
		
		// redirection
		setNextEvent(event="FizHandler.PostView", persist="postid");
	}
	
}