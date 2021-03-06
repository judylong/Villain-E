Capstone.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users",

  toJSON: function() {
    var json = { user: _.clone(this.attributes) };
    return json;
  },

  backed_projects: function() {
    if (!this._backed_projects) {
      this._backed_projects = new Capstone.Collections.Projects();
    }
    return this._backed_projects
  },

  created_projects: function() {
    if (!this._created_projects) {
      this._created_projects = new Capstone.Collections.Projects();
    }
    return this._created_projects;
  },

  parse: function(response) {
    if (response.backed_projects) {
      this.backed_projects().set(response.backed_projects);
      delete response.backed_projects;
    }
    if (response.created_projects) {
      this.created_projects().set(response.created_projects);
      delete response.created_projects;
    }
    return response;
  },

});

Capstone.Models.CurrentUser = Capstone.Models.User.extend({
  url: "/api/session",

  initialize: function(options) {
    this.listenTo(this, "change", this.fireSessionEvent);
  },

  isLoggedIn: function() {
    return !this.isNew();
  },

  logIn: function(options) {
    var model = this;
    var credentials = {
      "user[email]": options.email,
      "user[password]": options.password
    };

    $.ajax({
      url: this.url,
      type: "POST",
      data: credentials,
      dataType: "json",
      success: function(data) {
        model.set(data);
        options.success && options.success();
      },
      error: function() {
        options.error && options.error();
      }
    });
  },

  logOut: function(options) {
    var model = this;

    $.ajax({
      url: this.url,
      type: "DELETE",
      dataType: "json",
      success: function(data) {
        model.clear();
        options.success && options.success();
      }
    });
  },

  fireSessionEvent: function() {
    if (this.isLoggedIn()){
      this.trigger("logIn");
    } else {
      this.trigger("logOut");
    }
  }
});
