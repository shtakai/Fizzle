<!-- element to bind Kendo ListView to -->
<div id="postsListView"></div>

<!-- element to do our paging -->
<div id="pager"></div>

<!-- Kendo ListView Template -->
<script type="text/x-kendo-template" id="customListViewTemplate">
	<a href="<cfoutput>#Event.BuildLink('KendoBootstrapHandler.PostView')#</cfoutput>?postid=#:PostID#">
	<div class="row" id="postListItem">
		<div class="col-md-2">
			<h4>#:User.Nickname#</h4>
			<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>includes/images/avatar/#:User.Avatar#" alt="" width="100px" />		
		</div>
    	<div class="col-md-9">
			
			<h3 class="item-info">#:Subject#</h3>
			#:Body#
		</div>
	</div>
	</a>
</script>

<script>
	$( document ).ready(function() {
		// declare kendo datasource
		var remoteDataSource = new kendo.data.DataSource({
	    	transport: {
	        	read: {
					url: "index.cfm/KendoBootstrapHandler/GetPostListJSON",
					dataType: "json"	// required if JSON is being passed to us, else it thinks its a string
				}
	    	},
			//serverPaging: false,
			pageSize: 3
	    });
		/* DEBUGGING 
		remoteDataSource.fetch(function() {
  			//console.log("here");
			var view = remoteDataSource.view();
  			console.log(view.length);	
  			console.log(view[0].User.Email);
		});
		*/
		
		// declare the kendo pager
		$("#pager").kendoPager({
			dataSource: remoteDataSource
		});
		
		// declare the Kendo ListView and bind to it 
		$("#postsListView").kendoListView({
    		dataSource: remoteDataSource,
			template: $("#customListViewTemplate").html()
		});
			
	});	 
</script>
 <script>
    //var app = new kendo.Application(document.body);
</script>