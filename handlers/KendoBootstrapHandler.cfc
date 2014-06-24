component name="KendoBootstrapHandler" extends="coldbox.system.EventHandler" {
	
	// ORM injection
	property name="Utility" inject="fizzle.utilities.util";
	property name="PostService" inject="entityService:Post";
	property name="CommentService" inject="entityService:Comment";

	// Post List
	public void function PostList(event, rc, prc) {
		Event.setLayout("Layout.KendoBootstrap");
		Event.setView("KendoBootstrap/wvFizzleList");
	}

	// Post View
	public void function PostView(event, rc, prc) {
		rc.postid = rc.postid;
		Event.setLayout("Layout.KendoBootstrap");
		Event.setView("KendoBootstrap/vwFizzle");
	}

	// Post View w/ kendo splitter
	public void function PostViewSplitter(event, rc, prc) {
		Event.setLayout("Layout.KendoBootstrap");
		Event.setView("KendoBootstrap/vwFizzleSplitter");
	}

	// Add comment to database
	public boolean function AddComment(event, rc, prc) {
		//writedump(rc); abort;

		// populate and save new comment
		var comment = CommentService.New();
		comment.SetPostID(rc.postid);
		comment.SetUserID(getPlugin("SessionStorage").getVar("UserID"));
		comment.SetCommentText(rc.commenttext);
		
		// are we valid?
		var commentValid = validateModel(comment);
		if (commentValid.hasErrors()){
			return false;
		} else {
			CommentService.Save(comment);
			return true;
		}
	}
	
	// delete comment from database
	public boolean function DeleteComment(event, rc, prc) {
		var comment = CommentService.Get(rc.commentid);
		CommentService.Delete(comment);
		return true;
	}
	
	

	// ******************************************************************************************
	// 			API 																			 
	// ******************************************************************************************

	// GetPostList - will get all posts returned as a JSON string
	//public void function GetPostList(event, rc, prc) {
	//	var posts = GetPostListJSON();
	//	event.renderData(type="json", data=posts);
	//}
	

	
	// ******************************************************************************************
	// 			HELPER FUNCTIONS 																 
	// ******************************************************************************************
	
	// this method will get all posts and serialize them into a "posts" JSON string
	public string function GetPostListJSON() {
		var posts = PostService.getAll();
		
		// in order to have well formatted JSON (for Kendo) you need to encase in []
		var serializedPosts = '[';
		
		// need to serialize each item in post array
		for (item in posts) {
			serializedPosts &= SerializeJSON(Utility.EntityToStruct(item)) & ",";
			//serializedPosts &= SerializeJSON(item) & ",";
		}
		serializedPosts = Left(serializedPosts, len(serializedPosts)-1);	// remove last ,
		serializedPosts &= "]";
		return serializedPosts;
	}

	// this method will return an individual post and return as JSON string 
	public string function GetPostJSON(q) {
		var postJSON = "[";
		
		// get post by post id
		var post = PostService.Get(q);
		postJSON &= SerializeJSON(Utility.EntityToStruct(post)) & "]";
		
		return postJSON;
	}	
	
	
}