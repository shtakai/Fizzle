component output="false" singleton {

/* 
	GLOBAL IMPLICIT EVENTS ONLY 
	In order for these events to fire, you must declare them in the ColdBox.cfc
*/
		
	void function onAppInit(event, rc, prc) { }
		
	void function onRequestStart(event, rc, prc) { 
		/*		Security Check
		You need to check for the doLogin method, beacuse, if not, the doLogin method
		will never get a chance to be called.
		So check if the session.loggedin flag exists or not true, and if we
		are not logging in.
		*/
		
		// get default event collection from coldbox.cfc configuration file
		//var eventCollection = Event.getCollection();
		//writedump(Event.getCollection()); abort;

		//Set xeh's (extended event handlers)
		rc.xehLogout = "LoginHandler.doLogout";
		rc.xehHome = "LoginHandler.Home";

	}

	void function onRequestEnd(event, rc, prc) { }
	
	void function onSessionStart(event, rc, prc) { }
	
	void function onSessionEnd(event, rc, prc) { 
		var sessionScope = event.getValue("sessionReference");
		var applicationScope = event.getValue("applicationReference");
	}

	void function onException(event, rc, prc) { 
		//Grab Exception From request collection, placed by ColdBox
		var exceptionBean = event.getValue("ExceptionBean");
		//Place exception handler below:
	}	
	
	void function onMissingTemplate(event, rc, prc) { 
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");
	}
}