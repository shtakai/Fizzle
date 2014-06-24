component name="FizHandler" extends="coldbox.system.EventHandler" {
	
	// ORM injection
	property name="PostService" inject="entityService:Post";


	/***********************************************/
	// Post List
	/***********************************************/
	public void function Playground(event, rc, prc) {
		Event.setView("Playground/wvPlayground");
	}
	
	


	// return a simple hello world string
	function SayHelloWorld() {
		return "<h4>Hello World!</h4>";	
	}

	// Echo a simple string name in the request context
	public function EchoName(event, rc, prc) {
		return "<h4>Hello " & rc.name & " </h4>";
	}

	// GetJSONPostList - will return just JSON, no view
	public void function GetJSONPostList(event, rc, prc) {
		var posts = PostService.getAll();
		event.renderData(type="json", data=posts);
	}

	
}