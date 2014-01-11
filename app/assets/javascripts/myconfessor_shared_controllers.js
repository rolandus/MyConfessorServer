/* ==================================================================
 * Complex controllers shared by more than one app
 * ==================================================================
 */
(function(){

$MC.pages = {
	login: { name: "login", route: "login" },
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
		//":anything(/*)": "home"
	},
});
//Backbone.Router already includes Backbone.Events, so this is our router and our dispatcher
$MC.dispatcher = new $MC.Router();




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

    controllers: {
    	constructors: {},  //Put view constructor functions in here: name => constructor
    },
    
    //Set up default pages, one for authentication, and one for home.
    login_page: "",
    home_page: "",
    
    
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
     * Add listeners to various dispatcher events. OVERLOAD ME AND CALL SUPER!!!
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


})();
