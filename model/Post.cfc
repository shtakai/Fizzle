component name="Post" accessors="true" persistent="true" table="post" extends="coldbox.system.orm.hibernate.ActiveEntity" {
	
	// Primary Key
	property name="PostID" column="PostID" type="numeric" ormtype="int" fieldtype="id" generator="native" ;
	 
	// Properties or ORM table columns 
	property name="Subject" column="subject" type="string" ormtype="string";
	property name="Body" column="body" type="string" ormtype="string";
	
	// Foreign Key Relationships:
	// Post -> User = many-to-one
	property name="User" cfc="User" fieldtype="many-to-one"  fkcolumn="UserID";   
	
	// Post -> Comment = one-to-many
	property name="Comment" cfc="Comment" fieldtype="one-to-many" type="array" fkcolumn="PostID";   
	
	// form validation
	this.constraints = {
		Body = {required=true, min="1", max="140", sizeMessage="Fizzles are limited to {max} characters or less"}
	};
	
} 