module TestSupport
  def set_http_referer(url = '/')
    @request.env['HTTP_REFERER'] = url
  end
end