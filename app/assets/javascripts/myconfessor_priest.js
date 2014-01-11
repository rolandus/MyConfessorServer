/* ==================================================================
 * Controllers for the Admin app. 
 * ==================================================================
 */
(function(){

/**
 * Page names. They have to match the page names in the templates.
 */
_.extend($MC.pages,  
{
	new_confessor_request: { name: "new_confessor_request", route: "confessor_requests/new" },	
});

/**
 * Custom events handled by the dispatcher
 */
_.extend($MC.events.route,
{
	//Remember that 'route:' is prepended to routing events when they are fired!
	new_confessor_request: "route:" + $MC.pages.new_confessor_request.name,
});

/**
 * Application router and event dispatcher
 */
$MC.dispatcher.route("confessor_requests/new", $MC.pages.new_confessor_request.name); 


/* ==================================================================
 * Controllers for the Priest app. 
 * ==================================================================
 */

/**
 * Confessor Request creation page
 */
$MC.NewConfessorRequestView = $MC.PageView.extend({
	
	name: $MC.pages.new_confessor_request.name,
	requires_authentication: false,
	
	initialize: function() {
		$MC.PageView.prototype.initialize.apply(this, arguments);
		_.bindAll(this, "showOk");
	},
	
	events: {
		"click #new_confessor_request_commit": "submitRequest"
	},
	
	submitRequest: function(event) {
		var form;
		event.preventDefault();
		event.stopPropagation();
		form = new $MC.Form();
		form.compile($("#new_confessor_request_form"));
		form.save(null, { success: this.showOk });
	},
	
	showOk: function() {
		this.$el.find(".submit_ok").show();
	}
});


/**
 * Main application controller
 */
$MC.PriestMainView = $MC.MainView.extend({
    
    //======================================
    // Properties
    //======================================

    controllers: {
    	constructors: {
    		login: $MC.UserAccountLoginView,   					//User login TODO: needs to be moved to shared code
    		new_confessor_request: $MC.NewConfessorRequestView, //Confessor request creation page    		
    	},
    },
    
    //Set up default pages, one for authentication, and one for home.
    login_page: $MC.pages.login,
    home_page: $MC.pages.new_confessor_request,
    
    /**
     * Add listeners to various dispatcher events.
     */
    registerListeners: function() {
    	//Call super function, or the login stuff won't be wired up
    	$MC.MainView.prototype.registerListeners.apply(this, arguments);
    	
		//Create a confessor request
		$MC.dispatcher.on($MC.events.route.new_confessor_request, $.proxy(function(id) {
			console.debug("Routed to NewConfessorRequest");
			this.navigateToPage($MC.pages.new_confessor_request, { record_id: id });
		}, this));
    },
});


})(); //End closure
