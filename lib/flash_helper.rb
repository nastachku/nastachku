module FlashHelper

  [:success, :info].each do |kind|
    define_method "flash_#{kind}" do |options = {}|
      msg = options[:message] || kind
      flash_notice message: msg, kind: kind, now: options[:now]
    end
  end

  def flash_error(options = {})
    msg = options[:message] || :error
    now = options[:now] || true
    flash_notice message: msg, kind: :error, now: now
  end

  def flash_notice(options = {})
    msg = options[:message] || :notice
    msg = flash_translate msg if msg.is_a?(Symbol)
    kind = options[:kind] || :notice

    if options[:now]
      flash.now[kind] = msg
    else
      flash[kind] = msg
    end
  end

  def flash_translate(key)
    scope = [:flash, :controllers]
    scope += params[:controller].split('/')
    scope << params[:action]

    t(key, scope: scope)
  end

end