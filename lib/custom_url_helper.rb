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

  # TODO: рефакторинг
  def sort_link_href(search, attribute, direction, format)
    # Extract out a routing proxy for url_for scoping later
    if search.is_a?(Array)
      routing_proxy = search.shift
      search = search.first
    end
    raise TypeError, "First argument must be a Ransack::Search!" unless Ransack::Search === search

    attr_name = attribute.to_s
    options = {}
    query_hash = {
      q: {
        s: "#{attr_name} #{direction}"
      }
    }

    options.merge!(query_hash)
    options.merge!(format: format) if format
    if routing_proxy && respond_to?(routing_proxy)
      send(routing_proxy).url_for(options)
    else
      url_for(options)
    end
  end

end
