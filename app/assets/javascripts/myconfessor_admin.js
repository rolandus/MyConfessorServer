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
_.extend($MC.pages,
{
	login: { name: "login", route: "login" },
	confessor_requests: { name: "confessor_requests", route: "confessor_requests" },
	user_accounts: { name: "user_accounts", route: "user_accounts" },
	user_account: { name: "user_account", route: "user_accounts/:id" },
	edit_user_account: { name: "edit_user_account", route: "user_accounts/:id/edit" },
	new_user_account: { name: "new_user_account", route: "user_accounts/:id/new" },  //Id param is not used, but is needed to distinguish from the other user_accounts routes.
});

/**
 * Custom events handled by the dispatcher
 */
_.extend($MC.events,
{
	notify: {
		login: "notify:login",  //Login request returned successfully.
	},
	route: {
		//Remeber that 'route:' is prepended to routing events when they are fired!
		home: "route:home",
		login: "route:" + $MC.pages.login.name,
		confessor_requests: "route:" + $MC.pages.confessor_requests.name,
		user_accounts: "route:" + $MC.pages.user_accounts.name,
		user_account: "route:" + $MC.pages.user_account.name,
		edit_user_account: "route:" + $MC.pages.edit_user_account.name,
		new_user_account: "route:" + $MC.pages.new_user_account.name,
	},
});

/**
 * Application router and event dispatcher
 */
$MC.dispatcher.route($MC.pages.confessor_requests.route, $MC.pages.confessor_requests.name);
$MC.dispatcher.route($MC.pages.user_accounts.route, $MC.pages.user_accounts.name);
$MC.dispatcher.route($MC.pages.new_user_account.route, $MC.pages.new_user_account.name);
$MC.dispatcher.route($MC.pages.user_account.route, $MC.pages.user_account.name);
$MC.dispatcher.route($MC.pages.edit_user_account.route, $MC.pages.edit_user_account.name);


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
$MC.NewUserAccountView = $MC.PageView.extend({
	name: $MC.pages.new_user_account.name,
	template: new $MC.Template($MC.pages.edit_user_account.name),
	
	initialize: function() {
		$MC.PageView.prototype.initialize.apply(this, arguments);
		_.bindAll(this, "redirectToUser", "displayFormErrors");
	},
	
	events: {
		"click #user_account_commit": "submitRequest"
	},
	
	submitRequest: function(event) {
		var form;
		event.preventDefault();
		event.stopPropagation();
		form = new $MC.Form();
		form.compile($("#user_account_form"));
		form.save(null, { 
			success: this.redirectToUser,
			error: this.displayFormErrors
		});
	},
	
	redirectToUser: function(model) {
		$MC.dispatcher.navigate("user_accounts/" + model.id, { trigger: true, replace: true });
	},
	
	displayFormErrors: function(model, xhr) {
		var a = "something";
	}
});

/**
 * Main application controller
 */
$MC.AdminMainView = $MC.MainView.extend({
    
    //======================================
    // Properties
    //======================================

	//List of references to page controllers for the sub-pages.
    controllers: {
    	constructors: {
    		login: $MC.UserAccountLoginView,   				//User login TODO: needs to be moved to shared code
    		confessor_requests: $MC.ConfessorRequestsView,  //List of confessor requests
    		user_accounts: $MC.UserAccountsView,            //List of user accounts
    		user_account: $MC.UserAccountView,              //A single user account
    		edit_user_account: $MC.EditUserAccountView,     //Edit a user account
    		new_user_account: $MC.NewUserAccountView,       //Create a new user account
    	},
    },
    
    //Set up default pages, one for authentication, and one for home.
    login_page: $MC.pages.login,
    home_page: $MC.pages.confessor_requests,
    
    /**
     * Add listeners to various dispatcher events.
     */
    registerListeners: function() {
    	//Call super function, or the login stuff won't be wired up
    	$MC.MainView.prototype.registerListeners.apply(this, arguments);

    	
		//Confessor requests
		$MC.dispatcher.on($MC.events.route.confessor_requests, $.proxy(function() { 
			console.debug("Routed to ConfessorRequests");
			this.navigateToPage($MC.pages.confessor_requests);
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
});


})(); //End closure
