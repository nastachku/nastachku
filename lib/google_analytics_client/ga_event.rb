module GoogleAnalyticsClient
  module GaEvent
    GA_SOURCE_HOST = configus.analytics.host
    GA_HOST = "www.google-analytics.com"
    GA_PATH = "/collect"
    GA_VERSION = "1"
    GA_EVENT_TYPE = "event"
    GA_ID = "UA-38587983-1"

    def send_event(category, action, label = nil, value = nil, cookies = {})
      event_params = build_ga_params(category, action, label, value, cookies)
      begin
        perform_ga_request(event_params)
      rescue
        # well, it's just analytics, so let it crash
      end
    end

    private

    def build_ga_params(category, action, label, value, cookies)
      cid = extract_cid_from_cookies(cookies)

      params = {
        v: GA_VERSION,
        tid: GA_ID,
        cid: cid,
        t: GA_EVENT_TYPE,
        ec: category,
        ea: action,
        el: label,
        dh: GA_SOURCE_HOST,
        ev: value
      }

      params.compact
    end

    def perform_ga_request(params)
      uri = ga_url
      uri.query = URI.encode_www_form( params )
      Net::HTTP.get(uri)
    end

    def ga_url
      URI::HTTP.build(host: GA_HOST, path: GA_PATH)
    end

    def extract_cid_from_cookies(cookies = {})
      ga_cookie = cookies['_ga']
      if ga_cookie.present?
        ga_cookie.split('.')[-2, 2].try(:join, '.')
      else
        nil
      end
    end
  end
end
