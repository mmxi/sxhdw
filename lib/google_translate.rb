class GoogleTranslate
  def self.translate(word)
    api_url = URI.escape("http://translate.google.cn/translate_a/t?client=x&text=#{word}&sl=zh-CN&tl=en")
    uri = URI.parse(api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header({"User-Agent" => "Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1"})
    response = http.request(request)
    result = response.body
    obj_rel = JSON.parse(result)
    rel = obj_rel['sentences'][0]['trans']
  end
end