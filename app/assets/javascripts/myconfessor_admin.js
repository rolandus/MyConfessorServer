(function(){

/* ==================================================================
 * Setup code. TODO: This might belong in a different file, but it
 * won't all be shared between all three apps. So it's app-specific
 * setup.
 */

/**
 * Utility event dispatcher and even enums. Add events and listeners to this thing.
 */
$MC.dispatcher = _.clone(Backbone.Events);
$MC.events = {};
$MC.events.login = "login";

/**
 * Page names. They have to match the page names in the templates.
 */
$MC.pages = {};
$MC.pages.confessor_requests = "confessor_requests";
$MC.pages.new_confessor_request = "new_confessor_request";
$MC.pages.user_account_login = "user_account_login";


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
    name: $MC.pages.confessor_requests,
    collection: $MC.data.confessor_requests,
    item_view: $MC.ConfessorRequestItemView
});

/**
 * Confessor Request creation page
 */
$MC.NewConfessorRequestView = $MC.PageView.extend({
	
	name: $MC.pages.new_confessor_request,
	
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
    name: "user_accounts",
    collection: $MC.data.user_accounts
});

/**
 * A single user account view
 */
$MC.UserAccountView = $MC.ModelPageView.extend({
	name: "user_account",
	collection: $MC.data.user_accounts
});

/**
 * User account editing page
 */
$MC.EditUserAccountView = $MC.ModelPageView.extend({
	name: "edit_user_account",
	collection: $MC.data.user_accounts
});

/**
 * Login page.
 */
$MC.UserAccountLoginView = $MC.PageView.extend({
	
	name: $MC.pages.user_account_login,
	
	initialize: function() {
		$MC.PageView.prototype.initialize.apply(this, arguments);
		_.bindAll(this, "handleLogin");
	},
	
	events: {
		"click #user_account_login_commit": "submitRequest"
	},
	
	submitRequest: function(event) {
		var form;
		event.preventDefault();
		form = new $MC.Form();
		form.compile($("#user_account_login_form"));
		console.debug("logging in...");
		form.save(null, { success: this.handleLogin, error: this.handleLoginError });
	},
	
	handleLogin: function(model, response, options) {
		console.debug("handle login");
		$MC.dispatcher.trigger($MC.events.login, response);
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
    	constructors: {
    		confessor_requests: $MC.ConfessorRequestsView,  //List of confessor requests
    		new_confessor_request: $MC.NewConfessorRequestView, //Confessor request creation page
    		
    		user_accounts: $MC.UserAccountsView,            //List of user accounts
    		user_account: $MC.UserAccountView,              //A single user account
    		edit_user_account: $MC.EditUserAccountView,     //Edit a user account
    		user_account_login: $MC.UserAccountLoginView,   //User login
    	},
    },
    
    login_page: $MC.pages.user_account_login,
    home_page: $MC.pages.confessor_requests,
    
    
    //======================================
    // Functions
    //======================================
    
    initialize: function() {
    	_.bindAll(this, "finalizeLogin",  "finalizeLogout");
        this.fetchEnums();
        this.startEnumFetchListener();
        this.activateLinks();  //Wire up the page links to be all crazy-like.
        this.wireSharedEvents();
        if ($MC.user_account) {
        	this.finalizeLogin();
        }
        else {
        	this.finalizeLogout();
        }
    },
    
    wireSharedEvents: function() {
    	//Listen for login events and take the user to the home view.
    	$MC.dispatcher.on($MC.events.login, this.finalizeLogin);
    },
    
    start: function() {
    	//For debugging, show that all the static data has been loaded.
        $.each($MC.enums, function() {
            console.debug(this);
        });
    },
    
    /**
     * Attach listeners to all links with a 'data-page' attribute, which will cause
     * them to render pages using DOM injection rather than postbacks.
     */
    activateLinks: function() {
		$("body")
			.delegate("a[data-page]", "click", $.proxy(function(event) {
				var target    = event.currentTarget, //The event target is only being the link when you click in a very specific spot;
					info      = {};
				info.page = target.getAttribute("data-page"),
				info.record_id = target.getAttribute("data-record-id");
				event.preventDefault();
				event.stopPropagation();
				this.navigateToPage(info);
			}, this))
			.delegate("a.logout", "click", $.proxy(function(event) {
				event.preventDefault();
				event.stopPropagation();
				this.fireLogout(event.currentTarget);
			}, this));
    },
    
    fireLogout: function(linkElement) {
    	var url = linkElement.getAttribute("href");
		$.ajax(url, {
			type: "delete",
			success: $.proxy(function() {
				this.finalizeLogout();
			}, this)
		});
    },
    
    finalizeLogout: function() {
    	$MC.user_account = null;
    	this.hideUserAccountInfo();
    	this.hideToolbar();
    	this.navigateToPage({ page: this.login_page });
    },
    
    finalizeLogin: function(response) {
    	if (response) {
    		$MC.user_account = response;
    	}
    	this.showUserAccountInfo();
    	this.showToolbar();
    	this.navigateToPage({ page: this.home_page });
    },
    
    hideUserAccountInfo: function() {
    	$("#user_account_info").empty();
    },
    
    showUserAccountInfo: function() {    	
    	var template = new $MC.Template("user_account_info");    	
    	$("#user_account_info")
    		.empty()
    		.html(template.getHtmlFor($MC.user_account));    	
    },
    
    hideToolbar: function() {
    	$("#toolbar").hide();    	
    },
    
    showToolbar: function() {
    	$("#toolbar").show();    	
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
