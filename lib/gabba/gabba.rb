module Gabba
  class Gabba
    def event(category, action, label = nil, value = nil, utmni = false, utmhid = random_id, custom_params = {})
      check_account_params
      hey(event_params(category, action, label, value, utmni, utmhid, custom_params))
    end

    def event_params(category, action, label = nil, value = nil, utmni = false, utmhid = false, custom_params = {})
      raise ArgumentError.new("utmni must be a boolean") if (utmni.class != TrueClass && utmni.class != FalseClass)
      {
        :utmwv => @utmwv,
        :utmn => @utmn,
        :utmhn => @utmhn,
        :utmni => (1 if utmni), # 1 for non interactive event, excluded from bounce calcs
        :utmt => 'event',
        :utme => "#{event_data(category, action, label, value)}#{custom_var_data}",
        :utmcs => @utmcs,
        :utmul => @utmul,
        :utmhid => utmhid,
        :utmac => @utmac,
        :utmcc => @utmcc || cookie_params,
        :utmr => @utmr,
        :utmip => @utmip
      }.merge custom_params
    end
  end
end
