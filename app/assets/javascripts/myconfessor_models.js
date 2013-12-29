/* ==================================================================
 * Models and collections
 * ==================================================================
 */
(function(){

/**
 * Generic Model to serialize and submit a form as JSON.
 */
$MC.Form = Backbone.Model.extend(); //The reason we are not setting properties using the 'extend' function is that the properties (e.g. $form) get included as 'attributes' of the model, which we don't want.
$MC.Form.prototype.compile = function($form) {
	this.$form = $form; 
	this.urlRoot = $MC.settings.server_url + $form.attr("action");
	this.set($form.compile());
};

/**
 * Base collection for everything fetched as JSON. For now, it's just used to construct the URL.
 */
$MC.JSONCollection = Backbone.Collection.extend({
    server_url: $MC.settings.server_url + "/",
    url_suffix: ".json",
    url: function() {
        if(!this.cached_url) {
             this.cached_url = this.server_url + this.data_url + this.url_suffix;   
        }
        return this.cached_url;
    }   
});

//=============================================================
//===== Static Collections (enums)
//=============================================================
$MC.enums = {};
/**
 * The collection of account roles
 */
$MC.AccountRoleCollection = $MC.JSONCollection.extend({
    data_url: "account_roles"
});
$MC.enums.account_roles = new $MC.AccountRoleCollection();

/**
 * The collection of account statuses
 */
$MC.AccountStatusCollection = $MC.JSONCollection.extend({
    data_url: "account_statuses"
});
$MC.enums.account_statuses = new $MC.AccountStatusCollection();

/**
 * The collection of confession statuses
 */
$MC.ConfessionStatusCollection = $MC.JSONCollection.extend({
    data_url: "confession_statuses"
});
$MC.enums.confession_statuses = new $MC.ConfessionStatusCollection();

/**
 * The collection of confessor offices
 */
$MC.ConfessorOfficeCollection = $MC.JSONCollection.extend({
    data_url: "confessor_offices"
});
$MC.enums.confessor_offices = new $MC.ConfessorOfficeCollection();

/**
 * The collection of confessor request statuses
 */
$MC.ConfessorRequestStatusesCollection = $MC.JSONCollection.extend({
    data_url: "confessor_request_statuses"
});
$MC.enums.confessor_request_statuses = new $MC.ConfessorRequestStatusesCollection();

/**
 * The collection of dioceses
 */
$MC.DioceseCollection = $MC.JSONCollection.extend({
    data_url: "dioceses"
});
$MC.enums.dioceses = new $MC.DioceseCollection();

/**
 * The collection of states
 */
$MC.StateCollection = $MC.JSONCollection.extend({
    data_url: "states"
});
$MC.enums.states = new $MC.StateCollection();

//=============================================================
//===== Dynamic Models and Collections (data)
//=============================================================
$MC.data = {};
/**
 * The collection of confessor requests
 */
$MC.ConfessorRequest = Backbone.Model.extend();
$MC.ConfessorRequestCollection = $MC.JSONCollection.extend({
    data_url: "confessor_requests",
    model: $MC.ConfessorRequest
});
$MC.data.confessor_requests = new $MC.ConfessorRequestCollection();

/**
 * The collection of confessors
 */
$MC.ConfessorCollection = $MC.JSONCollection.extend({
    data_url: "confessors"
});
$MC.data.confessors = new $MC.ConfessorCollection();

/**
 * The collection of confession locations
 */
$MC.ConfessionLocationCollection = $MC.JSONCollection.extend({
    data_url: "confession_locations"
});
$MC.data.confession_locations = new $MC.ConfessionLocationCollection();

/**
 * The collection of user accounts
 */
$MC.UserAccountCollection = $MC.JSONCollection.extend({
    data_url: "user_accounts"
});
$MC.data.user_accounts = new $MC.UserAccountCollection();


})(); //End closure

