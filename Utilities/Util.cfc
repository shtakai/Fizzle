<cfcomponent>
<cffunction name="EntityToStruct" description="Converts an ORM entity to a struct">
    <cfargument name="object" hint="ORM entity to convert to struct">
    
    <!--- Var Scoping --->
    <cfscript>
        var struct = {};
        var property = '';
        var metadata = GetMetadata(arguments.object);
        var nestedMetadata = '';
        var value = '';
        var tempValue = [];
        var item = '';
        var tempItem = '';
    </cfscript>
    <!--- End Var Scoping --->
    
    <cfloop array="#metadata.properties#" index="property">
        
        <!--- Getters are predicatable, the word 'get' plus the property name, however they must be called with CFInvoke --->        
        <cfset getter = "get" & property.Name>
        <cfinvoke method="#getter#" component="#arguments.object#" returnvariable="value">
        
        <!--- Optional properties are undefined --->
        <cfif isNull(value)>
            <cfset value = ''>
        </cfif>
        
        <!--- Handle any nested components --->    
        <cfif isArray(value)>
            <cfset tempValue = []>
            <cfloop index="item" from="1" to="#arraylen(value)#">
                <cfset nestedMetadata = GetMetadata(value[item])>
                <cfif StructKeyExists(nestedMetadata,"type")>
                    <cfif nestedMetadata.type eq "component">
                        <cfset tempItem = value[item]>
                        <cfset arrayAppend(tempValue, EntityToStruct(tempItem))>
                    </cfif>
                </cfif>
            </cfloop>
            <cfset value = tempValue>
        <cfelse>
            <cfset nestedMetadata = GetMetadata(value)>
            <cfif StructKeyExists(nestedMetadata,"type")>
                <cfif nestedMetadata.type eq "component">
                    <cfset value = EntityToStruct(value)>
                </cfif>
            </cfif>            
        </cfif>
        
        <!--- Add to the new struct --->
        <cfset StructInsert(struct, property.Name, value)>

    </cfloop>
    
    <cfreturn struct>
</cffunction>	
</cfcomponent>
