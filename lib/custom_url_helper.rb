module CustomUrlHelper

  def sign_in_via_social_network_cpath(provider)
    "/auth/#{provider}"
  end

  def link_via_social_network_cpath(provider)
    "/auth/#{provider}"
  end

  def twitter_account_curl(twitter_name)
    "http://twitter.com/#{twitter_name}"
  end

  def edit_admin_event_cpath(event)
    case event
      when ::UserEvent
        edit_admin_event_path(event)
      when ::Event::Break
        edit_admin_event_break_path(event)
    end
  end

  def sort_clink(search, attribute, *args)
    # Extract out a routing proxy for url_for scoping later
    if search.is_a?(Array)
      routing_proxy = search.shift
      search = search.first
    end

    raise TypeError, "First argument must be a Ransack::Search!" unless Ransack::Search === search

    attr_name = attribute.to_s

    name = (args.size > 0 && !args.first.is_a?(Hash)) ? args.shift.to_s : ::Translate.attribute(attr_name, :context => search.context)

    if existing_sort = search.sorts.detect {|s| s.name == attr_name}
      prev_attr, prev_dir = existing_sort.name, existing_sort.dir
    end

    options = args.first.is_a?(Hash) ? args.shift.dup : {}
    default_order = options.delete :default_order
    current_dir = prev_attr == attr_name ? prev_dir : nil

    if current_dir
      new_dir = current_dir == 'desc' ? 'asc' : 'desc'
    else
      new_dir = default_order || 'asc'
    end

    html_options = args.first.is_a?(Hash) ? args.shift.dup : {}
    css = ['sort_link', current_dir].compact.join(' ')
    html_options[:class] = [css, html_options[:class]].compact.join(' ')
    query_hash = {
        s: "#{attr_name} #{new_dir}"
    }
    options.merge!(query_hash)

    url = if routing_proxy && respond_to?(routing_proxy)
            send(routing_proxy).url_for(options)
          else
            url_for(options)
          end

    link_to [ERB::Util.h(name), order_indicator_for(current_dir)].compact.join(' ').html_safe,
            url,
            html_options
  end

  def sort_link_href(search, attribute, direction)
    # Extract out a routing proxy for url_for scoping later
    if search.is_a?(Array)
      routing_proxy = search.shift
      search = search.first
    end
    raise TypeError, "First argument must be a Ransack::Search!" unless Ransack::Search === search

    attr_name = attribute.to_s
    options = {}
    query_hash = {
        s: "#{attr_name} #{direction}"
    }
    
    options.merge!(query_hash)
    
    url = if routing_proxy && respond_to?(routing_proxy)
            send(routing_proxy).url_for(options)
          else
            url_for(options)
          end
  end

end
