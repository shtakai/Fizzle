/* 
Single User Entity Object 
	
	Note: Extending from coldbox.system.orm.hibernate.ActiveEntity will make this entity come alive with tons of useful methods!
*/

component name="User" accessors="true" persistent="true" table="user" extends="coldbox.system.orm.hibernate.ActiveEntity" {
	
	// Primary Key
	property name="UserID" column="UserID" type="numeric" ormtype="int" fieldtype="id" generator="native" ;
	 
	// Properties or ORM table columns 
	property name="Email" column="email" type="string" ormtype="string"; 
	property name="FirstName" column="firstname" type="string" ormtype="string"; 
	property name="LastName" column="lastname" type="string" ormtype="string"; 
	property name="Password" column="password" type="string" ormtype="string";
	property name="Nickname" column="nickname" type="string" ormtype="string";
	property name="Avatar" column="avatar" type="string" ormtype="string"; 	
	
	// form validation
	this.constraints = {
		Email = {required=true, type="email"},
		FirstName = {required=true, requiredMessage="{field} is Required"},
		LastName = {required=true, requiredMessage="{field} is Required"},
		Password = {required=true, requiredMessage="{field} is Required"},
		Nickname = {required=true, requiredMessage="{field} is Required"}
		//changePasswordForm = {
		//	password = {required=true,min=6}, password2 = {required=true, sameAs="password", min=6}
		//}
	};
	
}