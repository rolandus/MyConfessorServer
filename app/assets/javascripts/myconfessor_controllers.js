/* ==================================================================
 * View Controllers
 * ==================================================================
 */
(function(){

/**
 * Base view for anything rendered using a template.
 */
$MC.TemplatedView = Backbone.View.extend({
	
	//Required override. You must provide a name.
	name: null,
	
	//Optional override. Default is to look up the template using the name (above)
	template: null,
	
	/**
	 * Constructor
	 */
	initialize: function() {
		//Call superconstructor
		Backbone.View.prototype.initialize.apply(this, arguments);

    	//Sanity checks
    	if (!this.name) { throw "A name is required to create a TemplatedView."; }

    	//Make sure these functions are always called in the context of this object
    	_.bindAll(this, "render");

    	//Set up the template if one was not supplied
        if (!this.template) {
        	this.template = new $MC.Template(this.name);
        }
  	},

	/**
	 * Render the view using the template.
	 */
	render: function() {
    	console.debug("rendering TemplatedView: " + this.name);
        this.$el.html(this.template.getHtml());
		this._is_rendered = true;
    }
});

/**
 * View for a single model. The model object is passed into the constructor.
 */
$MC.ModelView = $MC.TemplatedView.extend({
	
	/**
	 * Render this model using the given template.
	 */
	render: function() {
    	var modelObj, $element;
    	console.debug("rendering ModelView: " + this.name);
    	//"Serialize" the model
    	modelObj = this.model.toJSON(); 
    	//Create a DOM fragment from the template and add it to the parent element.
    	$element = $(this.template.getHtmlFor(modelObj));  
    	this.$el.append($element);
    	//After the element has been created and inserted, update $el to point to this element, instead of parent. 
		this.setElement($element.first());   	
    }
});
	
/**
 * Base controller for a page.
 */
$MC.PageView = $MC.TemplatedView.extend({

	/**
	 * Constructor.
	 */
	initialize: function() {
		var $element, template;
		
		//Call superconstructor
		$MC.TemplatedView.prototype.initialize.apply(this, arguments);

    	//Make sure these functions are always called in the context of this object
    	_.bindAll(this, "render", "hide", "show");
        
        //Set up the rendering container
        $element = $("#" + this.name + "_page");
        if ($element.length == 0) {
        	template = new $MC.Template("page_container");
        	$element = $(template.getHtmlFor({ name: this.name }));
        	$element.hide();
        	$MC.layout_content.append($element);
        }
        this.setElement($element.first());
	},
	
    /**
     * Hide the rendering container
     */
    hide: function() {
    	console.debug('hiding PageView: ' + this.name);
    	this.$el.hide();
    },
    
    /**
     * Show the rendering container
     */
    show: function() {
    	console.debug('showing PageView: ' + this.name);
 		if (!this._is_rendered) {
			this.render();
		}
   		this.$el.show();
    }
});

/**
 * Base controller for a basic page that has no model binding
 */
$MC.BasicPageView = $MC.PageView.extend({
	
	render: function() {
		$MC.PageView.prototype.render.apply(this, arguments);
		this._is_rendered = true;
	},
	
	show: function() {
		if (!this._is_rendered) {
			this.render();
		}
		$MC.PageView.prototype.show.apply(this, arguments);
	}
});


/**
 * Base controller for a page that shows a list of items (a collection-based page)
 */
$MC.ListPageView = $MC.PageView.extend({

	//Mandatory overrides. These must be overriden by the subclass.
	collection: null,  //Collection of data for this page
	item_view: null,   //Template to be used for individual items
	
	//Internal stuff
	item_views: [],    //Collection of individual views for the items
	
	/**
	 * Constructor.
	 */
	initialize: function() {
		//Call the super constructor
		$MC.PageView.prototype.initialize.apply(this, arguments);
		
    	//Sanity checks
    	if (!this.collection) { throw "A collection is required to create a ListPageView."; }
    	if (!this.item_view) { throw "An item view is required to create a ListPageView."; }
    	
        //Attach the collection for this page to the template.
        this.template.collection = this.collection;
        
        //Fetch the collection data, if needed.
        if (this.collection.length == 0) {
        	this.collection.fetch({ success: this.render });  //TODO: I bet there's a better way to bind rendering to when the collection is updated... I think there is. After creating the collection and the view, bind the view as a listener to the collection's events. That should wire it up automatically.
        }
	},
	
	render: function() {
		var $list_container = null,
		    str = "",
		    item_view = null;
		
		//Call the superclass's render.
		$MC.PageView.prototype.render.apply(this, arguments);
		
		$list_container = this.$(".list_container");
		this.collection.forEach($.proxy(function(item) {
			item_view = new this.item_view({ 
				model: item,
				el: $list_container
			});  //Should NOT be creating new views every time...
			this.item_views.push(item_view);
			item_view.render();
		}, this));
	}
});

/**
 * Base controller for a page that shows a single model.
 */
$MC.ModelPageView = $MC.PageView.extend({
	
	//Mandatory overrides. These must be overriden by the subclass.
	collection: null,  //Collection of data for this page
	record_id: null,   //Current ID in the collection that this view is displaying
	
	/**
	 * Constructor.
	 */
	initialize: function(options) {
		//Call the super constructor
		$MC.PageView.prototype.initialize.apply(this, arguments);
		
    	//Sanity checks
    	if (!this.collection) { throw "A collection is required to create a ModelPageView."; }
    	if (!options.record_id) { throw "A record ID is required to create a ModelPageView."; }
    	
    	//Attach the record id for this page to the template.
        this.template.collection = this.collection;
        this.setRecordId(options.record_id);		

        //Fetch the collection data, if needed.
        if (this.collection.length == 0) {
        	this.collection.fetch({ success: this.render });  //TODO: I bet there's a better way to bind rendering to when the collection is updated...
        }
	},
	
	/**
	 * Set the record ID for this view (which model to show)
 	 *  @param {Integer} id
	 */
	setRecordId: function(id) {
		this.record_id = this.template.record_id = id;
	},
	
	/**
	 * Overriden show function - handles this specific model
 	 *  @param {Object} info
	 */
	show: function(info) {
		if (this.collection.get(this.record_id)) {
			this.setRecordId(info.record_id);
			this.render();
		}
		$MC.PageView.prototype.show.apply(this, arguments);
	}
});


})();
