/* ==================================================================
 * View Controllers
 * ==================================================================
 */
(function(){
	
$MC.ModelView = Backbone.View.extend({
	
	name: null,
	template: null,
	
	initialize: function() {
		//Call superconstructor
		Backbone.View.prototype.initialize.apply(this, arguments);

    	//Sanity checks
    	if (!this.name) { throw "A name is required to create a ModelView."; }

    	//Make sure these functions are always called in the context of this object
    	_.bindAll(this, "render");

    	//Set up the template if one was not supplied
        if (!this.template) {
        	this.template = new $MC.Template(this.name);
        }
  	},

	render: function() {
    	var $element = $(this.template.getHtmlFor(this.model.toJSON()));
    	console.debug("rendering model...");
    	this.$el.append($element);
		this.setElement($element.first());  //After the element has been created and inserted, make sure the view's $el property is updated appropriately. 	
    }
});
	
/**
 * Base controller for a page.
 */
$MC.PageView = Backbone.View.extend({

	//Mandatory overrides. These must be overriden by the subclass.
	name: null,        //Name of this page. For example: "confessor_requests"
	
	//Optional overrides. This can overridden if desired. Default is to look up the template using 'name' above.
	template: null,    //Template to use for this page

	//"Private" properties
	_selector: null,   //jQuery selector used to find this page's rendering element.
	
	/**
	 * Constructor.
	 */
	initialize: function() {
		var $element, template, id;
		
		//Call superconstructor
		Backbone.View.prototype.initialize.apply(this, arguments);
    	
    	//Sanity checks
    	if (!this.name) { throw "A name is required to create a PageView."; }
    	
    	//Make sure these functions are always called in the context of this object
    	_.bindAll(this, "render", "hide", "show");
        
        if (!this.template) {
        	this.template = new $MC.Template(this.name);
        }
        
        //Set up the rendering container
        id = this.name + "_page";
        this._selector = "#" + id;
        $element = $(this._selector);
        if ($element.length == 0) {
        	template = new $MC.Template("page_container");
        	$element = $(template.getHtmlFor({ name: this.name }));
        	$element.hide();
        	$MC.layout_content.append($element);
        }
        this.setElement($element.first());
	},
	
	/**
	 * Render the page in the rendering container.
	 */
    render: function() {
    	console.debug("rendering page...");
        this.$el.html(this.template.getHtml());
    },
    
    /**
     * Hide the rendering container
     */
    hide: function() {
    	console.debug('hiding page...');
    	this.$el.hide();
    },
    
    /**
     * Show the rendering container
     */
    show: function() {
    	console.debug('showing page...');
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
