(function(){

/* ==================================================================
 * Setup code. TODO: This might belong in a different file, but it
 * won't all be shared between all three apps. So it's app-specific
 * setup.
 * ==================================================================
 */

/**
 * Page names. They have to match the page names in the templates.
 */
$MC.pages = {
	login: { name: "login", route: "login" },
	confessor_requests: { name: "confessor_requests", route: "confessor_requests" },
	new_confessor_request: { name: "new_confessor_request", route: "confessor_requests/new" },
	user_accounts: { name: "user_accounts", route: "user_accounts" },
	user_account: { name: "user_account", route: "user_accounts/:id" },
	edit_user_account: { name: "edit_user_account", route: "user_accounts/:id/edit" },
	new_user_account: { name: "new_user_account", route: "user_accounts/new" },
};

/**
 * Custom events handled by the dispatcher
 */
$MC.events = {
	notify: {
		login: "notify:login",  //Login request returned successfully.
	},
	route: {
		//Remeber that 'route:' is prepended to routing events when they are fired!
		home: "route:home",
		login: "route:" + $MC.pages.login.name,
		confessor_requests: "route:" + $MC.pages.confessor_requests.name,
		new_confessor_request: "route:" + $MC.pages.new_confessor_request.name,
		user_accounts: "route:" + $MC.pages.user_accounts.name,
		user_account: "route:" + $MC.pages.user_account.name,
		edit_user_account: "route:" + $MC.pages.edit_user_account.name,
		new_user_account: "route:" + $MC.pages.new_user_account.name,
	},
};
/**
 * Application router and event dispatcher
 */
$MC.Router = Backbone.Router.extend({
	//Remeber that 'route:' is prepended to these routing events when they are fired!
	routes: {
		"": "home",
		"login": $MC.pages.login.name,
		"logout": $MC.pages.login.name,
		"confessor_requests": $MC.pages.confessor_requests.name,
		"confessor_requests/new": $MC.pages.new_confessor_request.name,
		"user_accounts": $MC.pages.user_accounts.name,
		"user_accounts/new": $MC.pages.new_user_account.name,
		"user_accounts/:id": $MC.pages.user_account.name,
		"user_accounts/:id/edit": $MC.pages.edit_user_account.name,
		":anything(/*)": "home"
	},
});
//Backbone.Router already includes Backbone.Events, so this is our router and our dispatcher
$MC.dispatcher = new $MC.Router();


/* ==================================================================
 * Controllers for the Admin app. 
 * ==================================================================
 */
$MC.ConfessorRequestItemView = $MC.ModelView.extend({
	name: "confessor_request_item",
	
	events: {
		"click input.approve": "approveRequest"
	},
	
	approveRequest: function(event) {
		console.debug("Are you sure you want to approve " + this.model.get("first_name") + "?");
	}
});

/**
 * Confessor request list view controller
 */
$MC.ConfessorRequestsView = $MC.ListPageView.extend({
    name: $MC.pages.confessor_requests.name,
    collection: $MC.data.confessor_requests,
    item_view: $MC.ConfessorRequestItemView
});

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
		form = new $MC.Form();
		form.compile($("#new_confessor_request_form"));
		form.save(null, { success: this.showOk });
	},
	
	showOk: function() {
		this.$el.find(".submit_ok").show();
	}
});


$MC.UserAccountItemView = $MC.ModelView.extend({
	name: "user_account_item",
});

/**
 * User account list view controller
 */
$MC.UserAccountsView = $MC.ListPageView.extend({
    name: $MC.pages.user_accounts.name,
    collection: $MC.data.user_accounts,
    item_view: $MC.UserAccountItemView,
});

/**
 * A single user account view
 */
$MC.UserAccountView = $MC.ModelPageView.extend({
	name: $MC.pages.user_account.name,
	collection: $MC.data.user_accounts
});

/**
 * User account editing page
 */
$MC.EditUserAccountView = $MC.ModelPageView.extend({
	name: $MC.pages.edit_user_account.name,
	collection: $MC.data.user_accounts
});

/**
 * New account editing page
 */
$MC.NewUserAccountView = $MC.BasicPageView.extend({
	name: $MC.pages.new_user_account.name,
	template: new $MC.Template($MC.pages.edit_user_account.name),
});

/**
 * Login page.
 */
$MC.UserAccountLoginView = $MC.PageView.extend({
	
	name: $MC.pages.login.name,
	requires_authentication: false,
	
	initialize: function() {
		$MC.PageView.prototype.initialize.apply(this, arguments);
		_.bindAll(this, "handleLogin");
	},
	
	events: {
		"click #login_commit": "submitRequest"
	},
	
	submitRequest: function(event) {
		var form;
		event.preventDefault();
		form = new $MC.Form();
		form.compile($("#login_form"));
		console.debug("logging in...");
		form.save(null, { success: this.handleLogin, error: this.handleLoginError });
	},
	
	handleLogin: function(model, response, options) {
		console.debug("handle login");
		$MC.dispatcher.trigger($MC.events.notify.login, response);
	},
	
	handleLoginError: function() {
		console.debug("handle error");
		this.showError("credentials");
	},
	
	showError: function (type) {
		$("#login_" + type + "_error").show();
	},
	
	hideError: function (type) {
		$("#login_" + type + "_error").show();
	},
	
	hideAllErrors: function() {
		this.$(".login_error").hide();
	}
});


/**
 * Main application controller
 */
$MC.MainView = Backbone.View.extend({
    
    //======================================
    // Properties
    //======================================

	//List of references to page controllers for the sub-pages.
    controllers: {
    	constructors: {
    		confessor_requests: $MC.ConfessorRequestsView,  //List of confessor requests
    		new_confessor_request: $MC.NewConfessorRequestView, //Confessor request creation page
    		
    		user_accounts: $MC.UserAccountsView,            //List of user accounts
    		user_account: $MC.UserAccountView,              //A single user account
    		edit_user_account: $MC.EditUserAccountView,     //Edit a user account
    		new_user_account: $MC.NewUserAccountView,       //Create a new user account
    		login: $MC.UserAccountLoginView,   //User login
    	},
    },
    
    //Set up default pages, one for authentication, and one for home.
    login_page: $MC.pages.login,
    home_page: $MC.pages.confessor_requests,
    
    
    //======================================
    // Functions
    //======================================
    
    initialize: function() {
    	_.bindAll(this, "finalizeLogin",  "finalizeLogout");
        this.fetchEnums();
        this.startEnumFetchListener();
        this.activateLinks();     //Wire up the page links to be all crazy-like.
        this.registerListeners(); //Set up listeners for dispatcher events
    },
    
    /**
     * Fetch the data for all the collections listed as "static" data.
     */
    fetchEnums: function() {
        $.each($MC.enums, function() {
            this.fetch();
        });
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
     * Attach listeners to all links with a 'data-page' attribute, which will cause
     * them to render pages using DOM injection rather than postbacks.
     */
    activateLinks: function() {
		$("body")
			.delegate("a[data-page]", "click", $.proxy(function(event) {
				var target    = event.currentTarget, //The event target is only being the link when you click in a very specific spot;
					page,
					params = {};
				event.preventDefault();
				event.stopPropagation();
				$MC.dispatcher.navigate(target.getAttribute("href"), { trigger: true });
			}, this));
    },
    
    /**
     * Add listeners to various dispatcher events.
     */
    registerListeners: function() {
    	//Listen for login events and take the user to the home view.
    	$MC.dispatcher.on($MC.events.notify.login, this.finalizeLogin);
    	
    	//"Home"
		$MC.dispatcher.on($MC.events.route.home, $.proxy(function() { 
			console.debug("Routed to Home");
	        if ($MC.user_account) {
	        	//Redirect to home
	        	$MC.dispatcher.navigate(this.home_page.route, { trigger: true, replace: true });
	        }
	        else {
				//Redirect to login
				$MC.dispatcher.navigate(this.login_page.route, { trigger: true, replace: true });
	        }
     	}, this));
		//Login
		$MC.dispatcher.on($MC.events.route.login, $.proxy(function() { 			
			console.debug("Routed to Login");
	        this.requestLogout();
		}, this));
		//Confessor requests
		$MC.dispatcher.on($MC.events.route.confessor_requests, $.proxy(function() { 
			console.debug("Routed to ConfessorRequests");
			this.navigateToPage($MC.pages.confessor_requests);
		}, this));
		//Single confessor request
		$MC.dispatcher.on($MC.events.route.new_confessor_request, $.proxy(function(id) {
			console.debug("Routed to NewConfessorRequest");
			this.navigateToPage($MC.pages.new_confessor_request, { record_id: id });
		}, this));
		//User accounts
		$MC.dispatcher.on($MC.events.route.user_accounts, $.proxy(function() {
			console.debug("Routed to UserAccounts");
			this.navigateToPage($MC.pages.user_accounts);
		}, this));
		//Single user account
		$MC.dispatcher.on($MC.events.route.user_account, $.proxy(function(id) {
			console.debug("Routed to UserAccount");
			this.navigateToPage($MC.pages.user_account, { record_id: id });
		}, this));
		//Edit a user account
		$MC.dispatcher.on($MC.events.route.edit_user_account, $.proxy(function(id) {
			console.debug("Routed to EditUserAccount");
			this.navigateToPage($MC.pages.edit_user_account, { record_id: id });
		}, this));
		//Create a user account
		$MC.dispatcher.on($MC.events.route.new_user_account, $.proxy(function(id) {
			console.debug("Routed to NewUserAccount");
			this.navigateToPage($MC.pages.new_user_account);
		}, this));
    },
    
    /**
     * The "real" startup code. Called as soon as we know that we've loaded all resources.
     */
    start: function() {
    	//For debugging, show that all the static data has been loaded.
    	//In real life, we will probably stop showing the loading spinner, or something like that.
        $.each($MC.enums, function() {
            console.debug(this);
        });
        
        //Make sure we show naviationg
        if ($MC.user_account) {
        	this.showUserSkin();
        }
   		Backbone.history.start(); //Begin routing, which will fire the first navigation event and kick things off.
    },
    
    /**
     * Send a logout request to the server.
     */
    requestLogout: function() {
		$.ajax($MC.settings.log_out_url, {
			type: "delete",
			success: $.proxy(function() {
				this.finalizeLogout();
			}, this)
		});
    },
    
    /**
     * Remove the currently logged in user and navgiate to the login page.
     */
    finalizeLogout: function() {
    	$MC.user_account = null;
    	this.hideUserSkin();	
    	//DON'T trigger the event, since that will cause a cycle.
        $MC.dispatcher.navigate(this.login_page.route);
    	this.navigateToPage(this.login_page);
    },
    
    /**
     * Set the currently logged in user and navigate to the home page.
     */
    finalizeLogin: function(response) {
    	if (response) {
    		$MC.user_account = response;
    	}
    	this.showUserSkin();
    	console.debug('finalize login');
        $MC.dispatcher.navigate(this.home_page.route, { trigger: true, replace: true });
    },
    
    /**
     * Hide/show the username and logout button stuff.
     */
    hideUserAccountInfo: function() {
    	$("#user_account_info").empty();
    },    
    showUserAccountInfo: function() {    	
    	var template = new $MC.Template("user_account_info");    	
    	$("#user_account_info")
    		.empty()
    		.html(template.getHtmlFor($MC.user_account));    	
    },
    
    /**
     * Hide/show the toolbar
     */
    hideToolbar: function() {
    	$("#toolbar").hide();    	
    },    
    showToolbar: function() {
    	$("#toolbar").show();    	
    },
    
    /**
     * Collectively hide/show all logged-in user navigation
     */
    showUserSkin: function() {
    	this.showUserAccountInfo();
    	this.showToolbar();
    },
    hideUserSkin: function() {
    	this.hideUserAccountInfo();
    	this.hideToolbar();
    },
    
    /**
     * Called to change to a specific page within the app.
     */
    navigateToPage: function(page, params) {
    	var controller = this.getControllerFor(page, params);
    	if (this.current_controller) {
    		if (controller === this.current_controller) { return; }
    		this.current_controller.hide();
    	}
    	this.current_controller = controller;
    	this.current_controller.show(params);
    },
    
    /**
     * Get the specfied controller and create it if it doesn't exist.
     */
    getControllerFor: function(page, params) {
    	var controller = this.controllers[page.name];    	
    	if (!controller) {
    		console.debug("Creating controller for: " + page.name);
    		controller = this.controllers[page.name] = new this.controllers.constructors[page.name](params);
    	}
    	return controller;
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
    
});


})(); //End closure
