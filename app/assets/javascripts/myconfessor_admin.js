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
	confessor_requests: { name: "confessor_requests" },
	new_confessor_request: { name: "new_confessor_request" },
	login: { name: "login" },
	user_accounts: { name: "user_accounts" },
	user_account: { name: "user_account" },
	edit_user_account: { name: "edit_user_account" },
};

/**
 * Custom events handled by the dispatcher
 */
$MC.events = {
	notify: {
		login: "notify:login",  //Login request returned successfully.
	},
	route: {
		login: "route:" + $MC.pages.login.name,
		confessor_requests: "route:" + $MC.pages.confessor_requests.name,
		new_confessor_request: "route:" + $MC.pages.new_confessor_request.name,
		user_accounts: "route:" + $MC.pages.user_accounts.name,
		user_account: "route:" + $MC.pages.user_account.name,
		edit_user_account: "route:" + $MC.pages.edit_user_account.name,
	},
};
/**
 * Application router and event dispatcher
 */
$MC.Router = Backbone.Router.extend({
	routes: {
		"yup": "yup",
		"": $MC.pages.login.name,
		"login": $MC.pages.login.name,
		"confessor_requests": $MC.pages.confessor_requests.name,
		"confessor_requests/new": $MC.pages.new_confessor_request.name,
		"user_accounts": $MC.pages.user_accounts.name,
		"user_accounts/:id": $MC.pages.user_account.name,
		"user_accounts/:id/edit": $MC.pages.edit_user_account.name,
	},
});
//Backbone.Router already includes Backbone.Events, so this is our router and our dispatcher
$MC.dispatcher = new $MC.Router();
//Start routing once the DOM is ready.
$(function() {
	Backbone.history.start();
});



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

/**
 * User account list view controller
 */
$MC.UserAccountsView = $MC.ListPageView.extend({
    name: $MC.pages.user_accounts.name,
    collection: $MC.data.user_accounts
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
 * Login page.
 */
$MC.UserAccountLoginView = $MC.PageView.extend({
	
	name: $MC.pages.login.name,
	
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
				
				page = $MC.pages[target.getAttribute("data-page")];
				if (page) {
					params.record_id = target.getAttribute("data-record-id");
					this.navigateToPage(page, params);
				}
			}, this))
			.delegate("a.logout", "click", $.proxy(function(event) {
				event.preventDefault();
				event.stopPropagation();
				this.requestLogout(event.currentTarget);
			}, this));
    },
    
    /**
     * Add listeners to various dispatcther events.
     */
    registerListeners: function() {
    	//Listen for login events and take the user to the home view.
    	$MC.dispatcher.on($MC.events.notify.login, this.finalizeLogin);
    	
    	//Routing requests
    	/*
		$MC.dispatcher.on($MC.events.navigate, $.proxy(function(page, id) {
			console.debug("Received event to navigate to " + page + " " + id);
			if ($MC.pages[page]) {
				this.navigateToPage({ page: page, record_id: id });
			}
		}, this));
		*/
		
		//Login
		$MC.dispatcher.on($MC.events.route.login, $.proxy(function() { 
			this.finalizeLogout(); 
		}, this));
		//Confessor requests
		$MC.dispatcher.on($MC.events.route.confessor_requests, $.proxy(function() { 
			this.navigateToPage($MC.pages.confessor_requests);
		}, this));
		//Single confessor request
		$MC.dispatcher.on($MC.events.route.new_confessor_request, $.proxy(function(id) {
			this.navigateToPage($MC.pages.new_confessor_request, { record_id: id });
		}, this));
		//User accounts
		$MC.dispatcher.on($MC.events.route.user_accounts, $.proxy(function() {
			this.navigateToPage($MC.pages.user_accounts);
		}, this));
		//Single user account
		$MC.dispatcher.on($MC.events.route.user_account, $.proxy(function(id) {
			this.navigateToPage($MC.pages.user_account, { record_id: id });
		}, this));
		//Edit a user account
		$MC.dispatcher.on($MC.events.route.edit_user_accounts, $.proxy(function(id) {
			this.navigateToPage($MC.pages.user_account, { record_id: id });
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
        //Decide what to do based on whether the current user is logged in or not.
        if ($MC.user_account) {
        	this.finalizeLogin();
        }
        else {
        	this.finalizeLogout();
        }
    },
    
    /**
     * Send a logout request to the server.
     */
    requestLogout: function(linkElement) {
    	var url = linkElement.getAttribute("href");
		$.ajax(url, {
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
    	this.hideUserAccountInfo();
    	this.hideToolbar();
    	this.navigateToPage(this.login_page);
    },
    
    /**
     * Set the currently logged in user and navigate to the home page.
     */
    finalizeLogin: function(response) {
    	if (response) {
    		$MC.user_account = response;
    	}
    	this.showUserAccountInfo();
    	this.showToolbar();
    	this.navigateToPage(this.home_page);
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
