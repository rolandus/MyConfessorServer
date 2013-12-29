//Declare namespaces
var $MC = {};

(function(){
	
/* ==================================================================
 * App-level settings
 * ==================================================================
 */
$MC.settings = {
    server_url: "http://localhost:3000",
    are_templates_precompiled: false,
    data_polling_interval: 300
};
	
/* ==================================================================
 * Hacks and fixes
 * ==================================================================
 */
if(!window.console) { 
	window.console = {
		log: function(a){}, 
		info: function(a){}, 
		warn: function(a){}, 
		debug: function(a){}, 
		error: function(a){} 
	}; 
}

/* ==================================================================
 * DOM helpers
 * ==================================================================
 */
$MC.layout_header = $("#header");
$MC.layout_content = $("#content");
$MC.layout_footer = $("#footer");

/* ==================================================================
 * Handlebars helpers
 * ==================================================================
 */

/**
 * Handlebars helper used to convert an "enum" value into something useful (like a name or abbreviation)
 * 
 * Parameters
 *  @param {Integer} value The value to be dereferenced
 *  @param {String} enumName The enum name
 *  @param {String} property The property of the enum that will be returned. Default is "name".
 */
Handlebars.registerHelper("enum", function(value, enumName, property) {
	if (typeof property !== "string") { property = "name"; }
	return $MC.enums[enumName].get(value).get(property);
});

/**
 * Handlebars helper used to convert a record ID into something useful.
 * 
 * Parameters
 *  @param {Integer} id The id of the record to dereferenced
 *  @param {String} collection The name of the collection to select the record from
 *  @param {String} property The property that will be returned from the selected record
 */
Handlebars.registerHelper("record", function(id, collection, property) {
	if (typeof property !== "string") { throw "You must provide a property for the 'record' helper."; }
	return $MC.data[collection].get(id).get(property);
});

/**
 * Handlebars helper used to iterate over one of the enum values.
 *  @param {String} enumName The name of the enum collection to iterate over.
 */
Handlebars.registerHelper("iterateEnum", function(enumName, options) {
	var retVal;
	$MC.enums[enumName].forEach(function(item) {
		retVal = retVal + options.fn(item.attributes);
	});
	return retVal;
});

Handlebars.registerHelper("capitalize", function(style, options) {
	var str = options.fn(this);
	if (style == "all_upper") {
		str = str.toUpperCase();
	}
	return str;
});

/**
 * Template helper - abstracts the fact that the templates may
 * or may not be precompiled. If the scripts are not precompiled,
 * it assumes that each template lives in its own script tag
 * with an ID of the format "<template name>_tpl".
 * 
 * Parameters
 *  @param {String} name The name of the template.
 *  @param {Backbone.Collection} collection The (optional) collection of models being passed into the template.
 *  @param {Integer} record_id The (optional) record ID of the model we are rendering
 */
$MC.Template = function(name, collection, record_id) {
	this.name = name;
	this.collection = collection;
	this.record_id = record_id;
	if ($MC.settings.are_templates_precompiled) {
		this.template = Handlebars.templates[name];
	} else {
		this.template = Handlebars.compile($("#" + this.name + "_tpl").html());
	}
};
$MC.Template.prototype = {

	name: null,
	collection: null,
	record_id: null,
	
	/**
	 * Get the template HTML for the collection/model ID that was passed in at creation.
	 * If only a collection is passed in, it puts the whole collection into a context for a list view.
	 * If a collection and a record ID are passed in, it just renders that one model.
	 *  @return The HTML for this template.
	 */
	getHtml: function() {
		var context;
		if (this.collection) {
			if (this.record_id) {
				context = this.collection.get(this.record_id).toJSON();
			} else {
				context = { items: this.collection.toJSON() };
			}
		} else {
			context = {};
		}
		return this.template(context);
	},
	
	/**
	 * Get the template HTML for an arbitrary context object.
 	 *  @param {Object} context
 	 *  @return The HTML for this template.
	 */
	getHtmlFor: function(context) {
		return this.template(context);
	}
};

/* ==================================================================
 * JQuery helpers
 * ==================================================================
 */

/**
 * Attach a function to the jQuery object to handle gathering the form elements into a object.
 * @return An Object representing the contents of the form.
 */
$.fn.compile = function() {
    var retVal = {};
    $.each(this.serializeArray(), function() {  //Use jquery to get all the name/value pairs
    	var name = this.name,
    		pos  = name.indexOf("["),
    		model, 
    		property,
    		obj,
    		valueType;

		//Ensure existence of the object to which the property belongs
    	if (pos > -1) {  //Deal with rails-style form element names, like model[property].
    		model = name.substring(0, pos);
    		property = name.substring(pos+1, name.length-1);
    		if (typeof retVal[model] === "undefined") {
    			retVal[model] = { };
    		}
    		obj = retVal[model];
    	} else {
    		obj = retVal;
    		property = name;
    	}
    	
    	//Add the value to the property
    	valueType = typeof obj[property];
    	if (valueType === "undefined") {  //Value didn't exist
    		obj[property] = this.value;
    	} else if (valueType === "array") {  //Value exists and is already an array
			obj[property].push(this.value);
		} else {  //Value exists and needs to be converted into an array
			obj[property] = [ obj[property] ];
			obj[property].push(this.value);	
		}
    });
    return retVal;
};


})(); //End closure

