/* ==================================================================
 * Controllers for the Admin app. 
 * ==================================================================
 */
(function(){

/**
 * Confessor (Status) view controller
 */
$MC.ConfessorView = $MC.ModelPageView.extend({
	name: "confessor",
	collection: $MC.data.confessors
});

/**
 * Confession Location list view controller
 */
$MC.ConfessionLocationItemView = $MC.ModelView.extend({
	name: "confession_location_item"
});
$MC.ConfessionLocationsView = $MC.ListPageView.extend({
    name: "confession_locations",
    collection: $MC.data.confession_locations,
    item_view: $MC.ConfessionLocationItemView
});

/**
 * Edit Confession Location view controller
 */
$MC.EditLocationView = $MC.ModelPageView.extend({
	name: "edit_confession_location",
	collection: $MC.data.confession_locations
});

/**
 * New Confession Location view controller
 */
$MC.NewLocationView = $MC.ModelPageView.extend({
	name: "new_confession_location",
	collection: $MC.data.confession_locations
});

/*
 * User Account edit
 */
$MC.EditUserAccountView = $MC.ModelPageView.extend({
	name: "edit_user_account",
	collection: $MC.data.user_accounts
});



/**
 * Main application controller
 */
$MC.MainView = Backbone.View.extend({
    
    //======================================
    // Properties
    //======================================

    controllers: {
    	constructors: {
    		confessor: $MC.ConfessorView,  //Confessor Status page    		
    		
    		confession_locations: $MC.ConfessionLocationsView,          //List of Confession Locations
    		edit_confession_locations: $MC.EditConfessionLocationView,  //Edit a Confession Location
    		new_confession_locations: $MC.NewConfessionLocationView,    //Create a Confession Location
    		
    		edit_user_account: $MC.EditUserAccountView,  //Edit the User Account
    	},
		confessor: null,  		
		
		confession_locations: null,
		edit_confession_locations: null,
		new_confession_locations: null,
		
		edit_user_account: null,
    },
    
    
    //======================================
    // Functions
    //======================================
    
    initialize: function() {
        this.fetchEnums();
        this.startEnumFetchListener();
        this.activateLinks();  //Wire up the page links to be all crazy-like.
    },
    
    start: function() {
        $.each($MC.enums, function() {
            console.debug(this);
        });
    },
    
    /**
     * Attach listeners to all links with a 'data-page' attribute, which will cause
     * them to render pages using DOM injection rather than postbacks.
     */
    activateLinks: function() {
		$("body").delegate("a[data-page]", "click", $.proxy(function(event) {
			var target    = event.currentTarget, //The event target is only being the link when you click in a very specific spot;
				info      = {};
			info.page = target.getAttribute("data-page"),
			info.record_id = target.getAttribute("data-record-id");
			event.preventDefault();
			event.stopPropagation();
			this.navigateToPage(info);
		}, this));
    },
    
    /**
     * Called to change to a specific page within the app.
     *  @param {Object} info Hash of options (page, record_id)
     */
    navigateToPage: function(info) {
    	var controller = this.getControllerFor(info);
    	if (this.current_controller) {
    		this.current_controller.hide();
    	}
    	this.current_controller = controller;
    	this.current_controller.show(info);
    },
    
    /**
     * Get the specfied controller and create it if it doesn't exist.
     *  @param {Object} info Hash of options (page, record_id)
     *  @return The controller for the specified page.
     */
    getControllerFor: function(info) {
    	var controller = this.controllers[info.page];    	
    	if (!controller) {
    		console.debug("Creating controller for: " + info.page);
    		controller = this.controllers[info.page] = new this.controllers.constructors[info.page]({ record_id: info.record_id });
    	}
    	return controller;
    },
    
    /**
     * Starts polling to figure out when the static data is loaded.
     */
    startEnumFetchListener: function() {
        this._fetch_timer = window.setInterval($.proxy(function() {
            if (this.enumsAreFetched()) {
                window.clearInterval(this._fetch_timer);
                this.start();
            } 
        }, this), $MC.settings.data_polling_interval);
    },
    
    /**
     * @return True if all the static data is loaded; False otherwise.
     */
    enumsAreFetched: function() {
        var ready = true;
        $.each($MC.enums, function() {
            ready = ready && this.length > 0;
        });
        return ready;
    },
    
    /**
     * Fetch the data for all the collections listed as "static" data.
     */
    fetchEnums: function() {
        $.each($MC.enums, function() {
            this.fetch();
        });
    }
});


})(); //End closure
