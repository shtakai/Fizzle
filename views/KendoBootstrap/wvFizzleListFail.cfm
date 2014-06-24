<div class="row">
	<div class="col-md-2">

		<script type="text/kendo-x-tmpl" id="template">
		    <div>
		        Item template for #:name#
		    </div>
		 </script>
		 <div id ="listView"></div>
		 
	</div>
</div>

<script>
	$( document ).ready(function() {
		$("#datepicker").kendoDatePicker();
		
		// GET JSON and display with Kendo UI ListView
		$.ajax({
			dataType: "json",
			url: 'index.cfm/KendoBootstrapHandler/GetNameJSON',
			success: function(data) {
				// define kendo datasource
				var dataSource = new kendo.data.DataSource({
					data: data,
					schema: {
						groups: 'Posts'
					}
				});

				// initialize kendo ui listview
				//$("#listView").kendoListView({
				//	dataSource: data,
				//	template: kendo.template($("#template").html())
		        //});

				$("#listView").kendoListView({
				    dataSource: dataSource,
				    template: kendo.template($("#template").html()),
				});
			
			},
			error: function() {
				console.log("Fail");
				//$("tbody#fizzleList").append( "<tr><td>Failure!</td></tr>" );
			}
		});
	});
</script>


 <script>
 
</script>
