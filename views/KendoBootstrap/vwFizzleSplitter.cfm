<div id="fizzleView" style="height:800px">
<div id="vertical" style="height:800px">
	<div id="fizzle-pane">
    	<div id="horizontal" style="height:100%; width:100%;">
			<div id="fizzlePlaceholder"></div>
        </div>
    </div>
</div>
</div>


<!-- Kendo UI Template - Author Pane -->
<script type="text/x-kendo-template" id="authorTemplate">
	<div id="author-pane">
		<div class="pane-content">
    		<h4>#: User.Nickname #</h4>
			<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>includes/images/avatar/#: User.Avatar #" alt="" width="100px" />
    	</div>
	</div>
</script>


<!-- Kendo UI Template - Fizzle Pane -->
<script type="text/x-kendo-template" id="fizzleTemplate">
    <div id="fizzle-pane">
        <div class="pane-content">
            <h3>#: Subject #</h3>
            <p>#: Body #</p>
        </div>
    </div>
</script>


<!-- Kendo UI Template - Comment Pane -->
<script type="text/x-kendo-template" id="commentTemplate">
	<div id="comment-pane">
		<div class="row">
			<div class="col-md-3">
				<h4>#: User.Nickname #</h4>
				<img src="<cfoutput>#getSetting( 'htmlBaseURL' )#</cfoutput>includes/images/avatar/#: User.Avatar #" alt="" width="100px" />
			</div>
			<div class="col-md-7">#: CommentText #</div>
		</div>
	</div>
</script>
	
	
		
<script>
	$( document ).ready(function() {
		//console.log(getParameterByName('postid'));
	
		/*
		// declare kendo datasource
		var remoteDataSource = new kendo.data.DataSource({
	    	transport: {
	        	read: {
					url: "index.cfm/KendoBootstrapHandler/GetPostJSON",
					dataType: "json",	// required if JSON is being passed to us, else it thinks its a string
					data: {
						q: function() {
							return getParameterByName('postid')
						}
					}
				}
	    	}
	    });
		*/
		
		/* DEBUGGING 
		remoteDataSource.fetch(function() {
			var view = remoteDataSource.view();
				console.log(view.length);	
				console.log(view[0].Comment[0].CommentText);
		});
		*/


		$.getJSON( "index.cfm/KendoBootstrapHandler/GetPostJSON?q=" + getParameterByName('postid'), function( data ) {
			//console.log(data);


			// create default Kendo vertical Splitter 
			$("#vertical").kendoSplitter({
	            orientation: "vertical",
				min: "500px"
	        });
			// get handle of vertical splitter
			var verticalSplitter = $("#vertical").data("kendoSplitter");
		
			// iterate through comments and create a new pane for each one
			$.each(data[0].Comment, function(index, objComment){
				//console.log(objComment.User);
				var newPane = verticalSplitter.append({
					size: "200px",
					collapsible: false
				});

				// comment template
				var commentTemplateContent = $("#commentTemplate").html();
				var commentTemplate = kendo.template(commentTemplateContent);
				// render the template
				newPane.html(kendo.render(commentTemplate, jQuery.makeArray(objComment)));
			});
			
			
		    // create Kendo horizontal Splitter 
			$("#horizontal").kendoSplitter({
	            orientation: "horizontal",
				panes: [
                 	{ collapsible: false, resizable: false, size: "1px" }
				],
				min: "500px"
	        });
			// get handle of horizontal splitter
			var horizontalSplitter = $("#horizontal").data("kendoSplitter");

			// create author pane dynamically
			var authorPane = horizontalSplitter.append({
				size: "200px",
				collapsible: false
			});
			var authorTemplateContent = $("#authorTemplate").html();				// author template
			var authorTemplate = kendo.template(authorTemplateContent);
			authorPane.html(kendo.render(authorTemplate, jQuery.makeArray(data)));	// render the author template
			
			// create fizzle pane dynamically
			var fizzlePane = horizontalSplitter.append({
				collapsible: false
			});
			var fizzleTemplateContent = $("#fizzleTemplate").html();				// fizzle template
			var fizzleTemplate = kendo.template(fizzleTemplateContent);
			fizzlePane.html(kendo.render(fizzleTemplate, jQuery.makeArray(data)));	// render the fizzle template


		});		
	});
	
	// helper function to get query string parameter
	function getParameterByName(name) {
    	name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        	results = regex.exec(location.search);
    	return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	} 

</script>