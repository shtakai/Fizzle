<script>
	$('document').ready(function(){
		// Create a random Kendo UI ViewModel and populate a form with it
		var viewModel = kendo.observable({
			fname: "Chad",
			lname: "Meigs",
			fullname: function() {
				return this.get("fname") + ' ' + this.get("lname");
			}
		});
		kendo.bind($('form#testView'),viewModel);
		
		
		// Div loading of data
		$("#myDiv").load('index.cfm/PlaygroundHandler/SayHelloWorld');
		
		
		// GET - simple get and load into HTML
		$.get('index.cfm/PlaygroundHandler/SayHelloWorld', function(data){
			$('#myGETDiv').html(data)
		});
		
		
		// POST - get textbox data and echo it back to HTML
		$('button#nameButton').click( function() {
			$.ajax({
		        url: 'index.cfm/PlaygroundHandler/EchoName',
		        type: 'POST',
				data : $("input#name"),
				success: function(data) {
					console.log("Success");
					$('#echoNameDiv').html(data)
				},
				error: function( xhr, status, errorThrown ) {
        			alert( "Sorry, there was a problem!" );
        			console.log( "Error: " + errorThrown );
        			console.log( "Status: " + status );
        			console.dir( xhr );
    			}
    		});	// end ajax
		}); // end nameButton click
		
		
		// GET static JSON to display
		$.getJSON('index.cfm/PlaygroundHandler/GetJSONPostList', function(data) {
			var items = [];
			$.each(data, function () {
				$.each(this, function(key, val){
					switch (key) {
						case 'Subject':
							//console.log("Subject: " + val);
							$('div#myJSONREsultList ul').append('<li>' + val + '</li>');
							break;
						case 'Body':
							//console.log("Body: " + val);
					}
				});
			});
		}); // end getJSON
		

		
		// GET JSON and display with Kendo UI ListView
		$.ajax({
			dataType: "json",
			url: 'index.cfm/PlaygroundHandler/GetJSONPostList',
			success: function(data) {
				//console.log(data);
				// initialize kendo ui listview
				$("#listView").kendoListView({
		            template: "<li>${Subject}</li>",
					dataSource: data
		        });
			}
		});
		
			

		// call method on form submit
		//$("form#echoForm").on("submit", function(event) {
		//	//console.log("form was just submitted");
		//});
	});
</script>

<!-- Kendo UI test view -->
<form id="testView" name="testView">
	Firstname: <input id="firstName" type="text" data-bind="value: fname"><br/>
	Lastname: <input id="lastName" type="text" data-bind="value: lname"><br/>
	Fullname: <input id="fullname" type="text" data-bind="value: fullname"><br/>
	<input type="submit" />
</form>

<!-- Hello World - DIV loading of data -->
<div id="myDiv"></div>
<!-- Hello World - GET -->
<div id="myGETDiv"></div>


<!-- Echo Name String - POST -->
<form id="echoForm" name="echoForm">
	Name: <input id="name" name="name" type="text" />
	<Button type="button" id="nameButton">What's My Name?!!?</Button>
</form>	
<div id="echoNameDiv"></div>

<p>	
	JSON GET Subject:
	<div id="myJSONREsultList">
		<ul></ul>
	</div>
</p>
<br />

<p>Kendo UI List View:
	<ul id="listView"></ul>
</p>