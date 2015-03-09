(function() {
  var NodeTypes, ParameterMissing, Utils, createGlobalJsRoutesObject, defaults, root,
    __hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  ParameterMissing = function(message) {
    this.message = message;
  };

  ParameterMissing.prototype = new Error();

  defaults = {
    prefix: "",
    default_url_options: {}
  };

  NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8};

  Utils = {
    serialize: function(object, prefix) {
      var element, i, key, prop, result, s, _i, _len;

      if (prefix == null) {
        prefix = null;
      }
      if (!object) {
        return "";
      }
      if (!prefix && !(this.get_object_type(object) === "object")) {
        throw new Error("Url parameters should be a javascript hash");
      }
      if (root.jQuery) {
        result = root.jQuery.param(object);
        return (!result ? "" : result);
      }
      s = [];
      switch (this.get_object_type(object)) {
        case "array":
          for (i = _i = 0, _len = object.length; _i < _len; i = ++_i) {
            element = object[i];
            s.push(this.serialize(element, prefix + "[]"));
          }
          break;
        case "object":
          for (key in object) {
            if (!__hasProp.call(object, key)) continue;
            prop = object[key];
            if (!(prop != null)) {
              continue;
            }
            if (prefix != null) {
              key = "" + prefix + "[" + key + "]";
            }
            s.push(this.serialize(prop, key));
          }
          break;
        default:
          if (object) {
            s.push("" + (encodeURIComponent(prefix.toString())) + "=" + (encodeURIComponent(object.toString())));
          }
      }
      if (!s.length) {
        return "";
      }
      return s.join("&");
    },
    clean_path: function(path) {
      var last_index;

      path = path.split("://");
      last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/");
      return path.join("://");
    },
    set_default_url_options: function(optional_parts, options) {
      var i, part, _i, _len, _results;

      _results = [];
      for (i = _i = 0, _len = optional_parts.length; _i < _len; i = ++_i) {
        part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          _results.push(options[part] = defaults.default_url_options[part]);
        }
      }
      return _results;
    },
    extract_anchor: function(options) {
      var anchor;

      anchor = "";
      if (options.hasOwnProperty("anchor")) {
        anchor = "#" + options.anchor;
        delete options.anchor;
      }
      return anchor;
    },
    extract_trailing_slash: function(options) {
      var trailing_slash;

      trailing_slash = false;
      if (defaults.default_url_options.hasOwnProperty("trailing_slash")) {
        trailing_slash = defaults.default_url_options.trailing_slash;
      }
      if (options.hasOwnProperty("trailing_slash")) {
        trailing_slash = options.trailing_slash;
        delete options.trailing_slash;
      }
      return trailing_slash;
    },
    extract_options: function(number_of_params, args) {
      var last_el;

      last_el = args[args.length - 1];
      if (args.length > number_of_params || ((last_el != null) && "object" === this.get_object_type(last_el) && !this.look_like_serialized_model(last_el))) {
        return args.pop();
      } else {
        return {};
      }
    },
    look_like_serialized_model: function(object) {
      return "id" in object || "to_param" in object;
    },
    path_identifier: function(object) {
      var property;

      if (object === 0) {
        return "0";
      }
      if (!object) {
        return "";
      }
      property = object;
      if (this.get_object_type(object) === "object") {
        if ("to_param" in object) {
          property = object.to_param;
        } else if ("id" in object) {
          property = object.id;
        } else {
          property = object;
        }
        if (this.get_object_type(property) === "function") {
          property = property.call(object);
        }
      }
      return property.toString();
    },
    clone: function(obj) {
      var attr, copy, key;

      if ((obj == null) || "object" !== this.get_object_type(obj)) {
        return obj;
      }
      copy = obj.constructor();
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        attr = obj[key];
        copy[key] = attr;
      }
      return copy;
    },
    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var i, result, val, _i, _len;

      result = this.clone(options) || {};
      for (i = _i = 0, _len = required_parameters.length; _i < _len; i = ++_i) {
        val = required_parameters[i];
        if (i < actual_parameters.length) {
          result[val] = actual_parameters[i];
        }
      }
      return result;
    },
    build_path: function(required_parameters, optional_parts, route, args) {
      var anchor, opts, parameters, result, trailing_slash, url, url_params;

      args = Array.prototype.slice.call(args);
      opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }
      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      anchor = this.extract_anchor(parameters);
      trailing_slash = this.extract_trailing_slash(parameters);
      result = "" + (this.get_prefix()) + (this.visit(route, parameters));
      url = Utils.clean_path("" + result);
      if (trailing_slash === true) {
        url = url.replace(/(.*?)[\/]?$/, "$1/");
      }
      if ((url_params = this.serialize(parameters)).length) {
        url += "?" + url_params;
      }
      url += anchor;
      return url;
    },
    visit: function(route, parameters, optional) {
      var left, left_part, right, right_part, type, value;

      if (optional == null) {
        optional = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, parameters, true);
        case NodeTypes.STAR:
          return this.visit_globbing(left, parameters, true);
        case NodeTypes.LITERAL:
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
          return left;
        case NodeTypes.CAT:
          left_part = this.visit(left, parameters, optional);
          right_part = this.visit(right, parameters, optional);
          if (optional && !(left_part && right_part)) {
            return "";
          }
          return "" + left_part + right_part;
        case NodeTypes.SYMBOL:
          value = parameters[left];
          if (value != null) {
            delete parameters[left];
            return this.path_identifier(value);
          }
          if (optional) {
            return "";
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
          break;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    build_path_spec: function(route, wildcard) {
      var left, right, type;

      if (wildcard == null) {
        wildcard = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return "(" + (this.build_path_spec(left)) + ")";
        case NodeTypes.CAT:
          return "" + (this.build_path_spec(left)) + (this.build_path_spec(right));
        case NodeTypes.STAR:
          return this.build_path_spec(left, true);
        case NodeTypes.SYMBOL:
          if (wildcard === true) {
            return "" + (left[0] === '*' ? '' : '*') + left;
          } else {
            return ":" + left;
          }
          break;
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
        case NodeTypes.LITERAL:
          return left;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    visit_globbing: function(route, parameters, optional) {
      var left, right, type, value;

      type = route[0], left = route[1], right = route[2];
      if (left.replace(/^\*/i, "") !== left) {
        route[1] = left = left.replace(/^\*/i, "");
      }
      value = parameters[left];
      if (value == null) {
        return this.visit(route, parameters, optional);
      }
      parameters[left] = (function() {
        switch (this.get_object_type(value)) {
          case "array":
            return value.join("/");
          default:
            return value;
        }
      }).call(this);
      return this.visit(route, parameters, optional);
    },
    get_prefix: function() {
      var prefix;

      prefix = defaults.prefix;
      if (prefix !== "") {
        prefix = (prefix.match("/$") ? prefix : "" + prefix + "/");
      }
      return prefix;
    },
    route: function(required_parts, optional_parts, route_spec) {
      var path_fn;

      path_fn = function() {
        return Utils.build_path(required_parts, optional_parts, route_spec, arguments);
      };
      path_fn.required_params = required_parts;
      path_fn.toString = function() {
        return Utils.build_path_spec(route_spec);
      };
      return path_fn;
    },
    _classToTypeCache: null,
    _classToType: function() {
      var name, _i, _len, _ref;

      if (this._classToTypeCache != null) {
        return this._classToTypeCache;
      }
      this._classToTypeCache = {};
      _ref = "Boolean Number String Function Array Date RegExp Object Error".split(" ");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this._classToTypeCache["[object " + name + "]"] = name.toLowerCase();
      }
      return this._classToTypeCache;
    },
    get_object_type: function(obj) {
      if (root.jQuery && (root.jQuery.type != null)) {
        return root.jQuery.type(obj);
      }
      if (obj == null) {
        return "" + obj;
      }
      if (typeof obj === "object" || typeof obj === "function") {
        return this._classToType()[Object.prototype.toString.call(obj)] || "object";
      } else {
        return typeof obj;
      }
    }
  };

  createGlobalJsRoutesObject = function() {
    var namespace;

    namespace = function(mainRoot, namespaceString) {
      var current, parts;

      parts = (namespaceString ? namespaceString.split(".") : []);
      if (!parts.length) {
        return;
      }
      current = parts.shift();
      mainRoot[current] = mainRoot[current] || {};
      return namespace(mainRoot[current], parts.join("."));
    };
    namespace(root, "Routes");
    root.Routes = {
// accept_account_promo_code => /account/promo_codes/:id/accept(.:format)
  // function(id, options)
  accept_account_promo_code_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"promo_codes",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"accept",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// accept_admin_users_list => /admin/users_lists/:id/accept(.:format)
  // function(id, options)
  accept_admin_users_list_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users_lists",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"accept",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// account => /account(.:format)
  // function(options)
  account_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// account_lecture => /account/lectures/:id(.:format)
  // function(id, options)
  account_lecture_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// account_lectures => /account/lectures(.:format)
  // function(options)
  account_lectures_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"lectures",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// account_order => /account/orders/:id(.:format)
  // function(id, options)
  account_order_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// account_order_options => /account/order_options(.:format)
  // function(options)
  account_order_options_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"order_options",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// account_password => /account/password(.:format)
  // function(options)
  account_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"password",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// account_shirt_orders => /account/shirt_orders(.:format)
  // function(options)
  account_shirt_orders_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"shirt_orders",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// activate_account_tickets => /account/tickets/activate(.:format)
  // function(options)
  activate_account_tickets_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"tickets",false],[2,[7,"/",false],[2,[6,"activate",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// activate_user => /user/activate(.:format)
  // function(options)
  activate_user_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"user",false],[2,[7,"/",false],[2,[6,"activate",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// activation_account_tickets => /account/tickets/activation(.:format)
  // function(options)
  activation_account_tickets_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"tickets",false],[2,[7,"/",false],[2,[6,"activation",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_afterparty_tickets => /admin/afterparty_tickets(.:format)
  // function(options)
  admin_afterparty_tickets_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"afterparty_tickets",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_audits => /admin/audits(.:format)
  // function(options)
  admin_audits_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"audits",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_campaign => /admin/campaigns/:id(.:format)
  // function(id, options)
  admin_campaign_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"campaigns",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_campaigns => /admin/campaigns(.:format)
  // function(options)
  admin_campaigns_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"campaigns",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_distributor => /admin/distributors/:id(.:format)
  // function(id, options)
  admin_distributor_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"distributors",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_distributors => /admin/distributors(.:format)
  // function(options)
  admin_distributors_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"distributors",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_event => /admin/events/:id(.:format)
  // function(id, options)
  admin_event_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_event_break => /admin/event_breaks/:id(.:format)
  // function(id, options)
  admin_event_break_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"event_breaks",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_event_breaks => /admin/event_breaks(.:format)
  // function(options)
  admin_event_breaks_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"event_breaks",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_events => /admin/events(.:format)
  // function(options)
  admin_events_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"events",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_hall => /admin/halls/:id(.:format)
  // function(id, options)
  admin_hall_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"halls",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_halls => /admin/halls(.:format)
  // function(options)
  admin_halls_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"halls",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_lecture => /admin/lectures/:id(.:format)
  // function(id, options)
  admin_lecture_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_lectures => /admin/lectures(.:format)
  // function(options)
  admin_lectures_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"lectures",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_mailers => /admin/mailers(.:format)
  // function(options)
  admin_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"mailers",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_news => /admin/news/:id(.:format)
  // function(id, options)
  admin_news_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"news",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_news_index => /admin/news(.:format)
  // function(options)
  admin_news_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"news",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_order => /admin/orders/:id(.:format)
  // function(id, options)
  admin_order_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_orders => /admin/orders(.:format)
  // function(options)
  admin_orders_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"orders",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_page => /admin/pages/:id(.:format)
  // function(id, options)
  admin_page_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_pages => /admin/pages(.:format)
  // function(options)
  admin_pages_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"pages",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_reports_file => /admin/downloads/reports/*filename(.:format)
  // function(filename, options)
  admin_reports_file_path: Utils.route(["filename"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"downloads",false],[2,[7,"/",false],[2,[6,"reports",false],[2,[7,"/",false],[2,[5,[3,"*filename",false],false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// admin_resque => /admin/resque
  // function(options)
  admin_resque_path: Utils.route([], [], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[6,"resque",false]]]], arguments),
// admin_root => /admin(.:format)
  // function(options)
  admin_root_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// admin_ticket_code => /admin/ticket_codes/:id(.:format)
  // function(id, options)
  admin_ticket_code_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"ticket_codes",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_ticket_codes => /admin/ticket_codes(.:format)
  // function(options)
  admin_ticket_codes_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"ticket_codes",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_tickets => /admin/tickets(.:format)
  // function(options)
  admin_tickets_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"tickets",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_topic => /admin/topics/:id(.:format)
  // function(id, options)
  admin_topic_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"topics",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_topics => /admin/topics(.:format)
  // function(options)
  admin_topics_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"topics",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_user => /admin/users/:id(.:format)
  // function(id, options)
  admin_user_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_users => /admin/users(.:format)
  // function(options)
  admin_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_users_list => /admin/users_lists/:id(.:format)
  // function(id, options)
  admin_users_list_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users_lists",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_users_lists => /admin/users_lists(.:format)
  // function(options)
  admin_users_lists_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users_lists",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// admin_workshop => /admin/workshops/:id(.:format)
  // function(id, options)
  admin_workshop_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"workshops",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// admin_workshops => /admin/workshops(.:format)
  // function(options)
  admin_workshops_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"workshops",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// api_campaigns_discount => /api/campaigns/discount(.:format)
  // function(options)
  api_campaigns_discount_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"campaigns",false],[2,[7,"/",false],[2,[6,"discount",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// api_cities => /api/cities(.:format)
  // function(options)
  api_cities_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"cities",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// api_city => /api/cities/:id(.:format)
  // function(id, options)
  api_city_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"cities",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// api_companies => /api/companies(.:format)
  // function(options)
  api_companies_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"companies",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// api_company => /api/companies/:id(.:format)
  // function(id, options)
  api_company_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"companies",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// api_event_event_votings => /api/events/:event_id/event_votings(.:format)
  // function(event_id, options)
  api_event_event_votings_path: Utils.route(["event_id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"event_id",false],[2,[7,"/",false],[2,[6,"event_votings",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_events => /api/events(.:format)
  // function(options)
  api_events_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"events",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// api_lecture => /api/lectures/:id(.:format)
  // function(id, options)
  api_lecture_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// api_lecture_lecture_votings => /api/lectures/:lecture_id/lecture_votings(.:format)
  // function(lecture_id, options)
  api_lecture_lecture_votings_path: Utils.route(["lecture_id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"lecture_id",false],[2,[7,"/",false],[2,[6,"lecture_votings",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_lecture_listener_votings => /api/lectures/:lecture_id/listener_votings(.:format)
  // function(lecture_id, options)
  api_lecture_listener_votings_path: Utils.route(["lecture_id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"lecture_id",false],[2,[7,"/",false],[2,[6,"listener_votings",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_lectures => /api/lectures(.:format)
  // function(options)
  api_lectures_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// approve_account_orders => /account/orders/approve(.:format)
  // function(options)
  approve_account_orders_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[6,"approve",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// audits_index => /audits/index(.:format)
  // function(options)
  audits_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"audits",false],[2,[7,"/",false],[2,[6,"index",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// authorization_social_networks => /social_networks/authorization(.:format)
  // function(options)
  authorization_social_networks_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"social_networks",false],[2,[7,"/",false],[2,[6,"authorization",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// banned => /banned(.:format)
  // function(options)
  banned_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"banned",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// broadcast_admin_mailers => /admin/mailers/broadcast(.:format)
  // function(options)
  broadcast_admin_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"mailers",false],[2,[7,"/",false],[2,[6,"broadcast",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// broadcast_to_admins_admin_mailers => /admin/mailers/broadcast_to_admins(.:format)
  // function(options)
  broadcast_to_admins_admin_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"mailers",false],[2,[7,"/",false],[2,[6,"broadcast_to_admins",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// broadcast_to_not_attended_admin_mailers => /admin/mailers/broadcast_to_not_attended(.:format)
  // function(options)
  broadcast_to_not_attended_admin_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"mailers",false],[2,[7,"/",false],[2,[6,"broadcast_to_not_attended",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// buy_now => /buy_now(.:format)
  // function(options)
  buy_now_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"buy_now",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// buy_now_order => /buy_now_order(.:format)
  // function(options)
  buy_now_order_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"buy_now_order",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// cancel_account_orders => /account/orders/cancel(.:format)
  // function(options)
  cancel_account_orders_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[6,"cancel",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// ckeditor.pictures => /ckeditor/pictures(.:format)
  // function(options)
  ckeditor_pictures_path: Utils.route([], ["format"], [2,[2,[2,[7,"/",false],[6,"ckeditor",false]],[7,"/",false]],[2,[6,"pictures",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// ckeditor.picture => /ckeditor/pictures/:id(.:format)
  // function(id, options)
  ckeditor_picture_path: Utils.route(["id"], ["format"], [2,[2,[2,[7,"/",false],[6,"ckeditor",false]],[7,"/",false]],[2,[6,"pictures",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// ckeditor.attachment_files => /ckeditor/attachment_files(.:format)
  // function(options)
  ckeditor_attachment_files_path: Utils.route([], ["format"], [2,[2,[2,[7,"/",false],[6,"ckeditor",false]],[7,"/",false]],[2,[6,"attachment_files",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// ckeditor.attachment_file => /ckeditor/attachment_files/:id(.:format)
  // function(id, options)
  ckeditor_attachment_file_path: Utils.route(["id"], ["format"], [2,[2,[2,[7,"/",false],[6,"ckeditor",false]],[7,"/",false]],[2,[6,"attachment_files",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// create_paid_part_admin_users_list => /admin/users_lists/:id/create_paid_part(.:format)
  // function(id, options)
  create_paid_part_admin_users_list_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users_lists",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"create_paid_part",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// decline_account_orders => /account/orders/decline(.:format)
  // function(options)
  decline_account_orders_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[6,"decline",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// discount_account => /account/discount(.:format)
  // function(options)
  discount_account_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"discount",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// edit_account => /account/edit(.:format)
  // function(options)
  edit_account_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// edit_account_password => /account/password/edit(.:format)
  // function(options)
  edit_account_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"password",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// edit_admin_distributor => /admin/distributors/:id/edit(.:format)
  // function(id, options)
  edit_admin_distributor_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"distributors",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_event => /admin/events/:id/edit(.:format)
  // function(id, options)
  edit_admin_event_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_event_break => /admin/event_breaks/:id/edit(.:format)
  // function(id, options)
  edit_admin_event_break_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"event_breaks",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_hall => /admin/halls/:id/edit(.:format)
  // function(id, options)
  edit_admin_hall_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"halls",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_lecture => /admin/lectures/:id/edit(.:format)
  // function(id, options)
  edit_admin_lecture_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_news => /admin/news/:id/edit(.:format)
  // function(id, options)
  edit_admin_news_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"news",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_order => /admin/orders/:id/edit(.:format)
  // function(id, options)
  edit_admin_order_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_page => /admin/pages/:id/edit(.:format)
  // function(id, options)
  edit_admin_page_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_topic => /admin/topics/:id/edit(.:format)
  // function(id, options)
  edit_admin_topic_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"topics",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_user => /admin/users/:id/edit(.:format)
  // function(id, options)
  edit_admin_user_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_workshop => /admin/workshops/:id/edit(.:format)
  // function(id, options)
  edit_admin_workshop_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"workshops",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_api_city => /api/cities/:id/edit(.:format)
  // function(id, options)
  edit_api_city_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"cities",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_api_company => /api/companies/:id/edit(.:format)
  // function(id, options)
  edit_api_company_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"companies",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_api_lecture => /api/lectures/:id/edit(.:format)
  // function(id, options)
  edit_api_lecture_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// generate_admin_reports => /admin/reports/generate(.:format)
  // function(options)
  generate_admin_reports_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"reports",false],[2,[7,"/",false],[2,[6,"generate",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// give_badge_registrator_users => /registrator/users/give_badge(.:format)
  // function(options)
  give_badge_registrator_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"registrator",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"give_badge",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// lectors => /lectors(.:format)
  // function(options)
  lectors_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"lectors",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// lectures => /lectures(.:format)
  // function(options)
  lectures_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"lectures",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// new_account_lecture => /account/lectures/new(.:format)
  // function(options)
  new_account_lecture_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_account_shirt_order => /account/shirt_orders/new(.:format)
  // function(options)
  new_account_shirt_order_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"shirt_orders",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_campaign => /admin/campaigns/new(.:format)
  // function(options)
  new_admin_campaign_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"campaigns",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_distributor => /admin/distributors/new(.:format)
  // function(options)
  new_admin_distributor_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"distributors",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_event => /admin/events/new(.:format)
  // function(options)
  new_admin_event_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_event_break => /admin/event_breaks/new(.:format)
  // function(options)
  new_admin_event_break_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"event_breaks",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_hall => /admin/halls/new(.:format)
  // function(options)
  new_admin_hall_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"halls",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_lecture => /admin/lectures/new(.:format)
  // function(options)
  new_admin_lecture_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_news => /admin/news/new(.:format)
  // function(options)
  new_admin_news_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"news",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_page => /admin/pages/new(.:format)
  // function(options)
  new_admin_page_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_ticket_code => /admin/ticket_codes/new(.:format)
  // function(options)
  new_admin_ticket_code_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"ticket_codes",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_topic => /admin/topics/new(.:format)
  // function(options)
  new_admin_topic_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"topics",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_users_list => /admin/users_lists/new(.:format)
  // function(options)
  new_admin_users_list_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"users_lists",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_workshop => /admin/workshops/new(.:format)
  // function(options)
  new_admin_workshop_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"workshops",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_api_city => /api/cities/new(.:format)
  // function(options)
  new_api_city_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"cities",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_api_company => /api/companies/new(.:format)
  // function(options)
  new_api_company_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"companies",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_api_lecture => /api/lectures/new(.:format)
  // function(options)
  new_api_lecture_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"lectures",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_buy_now_order => /buy_now_order/new(.:format)
  // function(options)
  new_buy_now_order_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"buy_now_order",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_registrator_users => /registrator/users/new(.:format)
  // function(options)
  new_registrator_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"registrator",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_remind_password => /remind_password/new(.:format)
  // function(options)
  new_remind_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"remind_password",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_session => /session/new(.:format)
  // function(options)
  new_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"session",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// new_user => /users/new(.:format)
  // function(options)
  new_user_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// news_index => /news(.:format)
  // function(options)
  news_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"news",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// page => /pages/:id(.:format)
  // function(id, options)
  page_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"pages",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// pay_account_buy => /account/buy/pay(.:format)
  // function(options)
  pay_account_buy_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"buy",false],[2,[7,"/",false],[2,[6,"pay",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// pay_account_order => /account/orders/:id/pay(.:format)
  // function(id, options)
  pay_account_order_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"account",false],[2,[7,"/",false],[2,[6,"orders",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"pay",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// payments_cancel_payanyway => /payments/cancel/payanyway(.:format)
  // function(options)
  payments_cancel_payanyway_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"payments",false],[2,[7,"/",false],[2,[6,"cancel",false],[2,[7,"/",false],[2,[6,"payanyway",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// payments_decline_payanyway => /payments/decline/payanyway(.:format)
  // function(options)
  payments_decline_payanyway_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"payments",false],[2,[7,"/",false],[2,[6,"decline",false],[2,[7,"/",false],[2,[6,"payanyway",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// payments_paid_payanyway => /payments/paid/payanyway(.:format)
  // function(options)
  payments_paid_payanyway_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"payments",false],[2,[7,"/",false],[2,[6,"paid",false],[2,[7,"/",false],[2,[6,"payanyway",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// payments_success_payanyway => /payments/success/payanyway(.:format)
  // function(options)
  payments_success_payanyway_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"payments",false],[2,[7,"/",false],[2,[6,"success",false],[2,[7,"/",false],[2,[6,"payanyway",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// preview => /mailer_preview
  // function(options)
  preview_path: Utils.route([], [], [2,[7,"/",false],[6,"mailer_preview",false]], arguments),
// preview_admin_mailers => /admin/mailers/preview(.:format)
  // function(options)
  preview_admin_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"mailers",false],[2,[7,"/",false],[2,[6,"preview",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// promo => /promo/:id(.:format)
  // function(id, options)
  promo_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"promo",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// rails_info => /rails/info(.:format)
  // function(options)
  rails_info_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// rails_info_properties => /rails/info/properties(.:format)
  // function(options)
  rails_info_properties_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"properties",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_info_routes => /rails/info/routes(.:format)
  // function(options)
  rails_info_routes_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"routes",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_mailers => /rails/mailers(.:format)
  // function(options)
  rails_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"mailers",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// registrator_root => /registrator(.:format)
  // function(options)
  registrator_root_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"registrator",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// registrator_users => /registrator/users(.:format)
  // function(options)
  registrator_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"registrator",false],[2,[7,"/",false],[2,[6,"users",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// remind_password => /remind_password(.:format)
  // function(options)
  remind_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"remind_password",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// root => /
  // function(options)
  root_path: Utils.route([], [], [7,"/",false], arguments),
// schedule => /schedule(.:format)
  // function(options)
  schedule_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"schedule",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// session => /session(.:format)
  // function(options)
  session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"session",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// sort_api_halls => /api/halls/sort(.:format)
  // function(options)
  sort_api_halls_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"halls",false],[2,[7,"/",false],[2,[6,"sort",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// success_buy_now_order => /buy_now_order/success(.:format)
  // function(options)
  success_buy_now_order_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"buy_now_order",false],[2,[7,"/",false],[2,[6,"success",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// user_lectures => /user_lectures(.:format)
  // function(options)
  user_lectures_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"user_lectures",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// users => /users(.:format)
  // function(options)
  users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"users",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// web_admin_afterparty_tickets_index => /web/admin/afterparty_tickets/index(.:format)
  // function(options)
  web_admin_afterparty_tickets_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"web",false],[2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"afterparty_tickets",false],[2,[7,"/",false],[2,[6,"index",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// welcome_index => /welcome(.:format)
  // function(options)
  welcome_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"welcome",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// with_badge_registrator_users => /registrator/users/with_badge(.:format)
  // function(options)
  with_badge_registrator_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"registrator",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"with_badge",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments)}
;
    root.Routes.options = defaults;
    return root.Routes;
  };

  if (typeof define === "function" && define.amd) {
    define([], function() {
      return createGlobalJsRoutesObject();
    });
  } else {
    createGlobalJsRoutesObject();
  }

}).call(this);
