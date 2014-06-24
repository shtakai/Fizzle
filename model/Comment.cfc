component name="Post" accessors="true" persistent="true" table="comment" extends="coldbox.system.orm.hibernate.ActiveEntity" {
	
	// Primary Key
	property name="CommentID" column="CommentID" type="numeric" ormtype="int" fieldtype="id" generator="native" ;
	
	// Properties or ORM table columns 
	property name="PostID" column="PostID" type="numeric" ormtype="int";
	property name="UserID" column="UserID" type="numeric" ormtype="int";
	property name="CommentText" column="CommentText" type="string" ormtype="string";
	
	// Foreign Key Relationships:
	// Comment -> Post = many-to-one
	//property name="Post" cfc="Post" fieldtype="many-to-one"  fkcolumn="PostID";
	   
	// Comment -> User = many-to-one
	property name="User" cfc="User" fieldtype="many-to-one" fkcolumn="UserID" insert="false" update="false";   

	// form validation
	this.constraints = {
		CommentText = {required=true, size="1..140", sizeMessage="Comments are limited to {max} characters or less"}
	};

}