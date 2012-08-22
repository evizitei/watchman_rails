class UrlShortener
  def self.shorten(url)
    Bitly.use_api_version_3
    bit = Bitly.new("evizitei", 'R_b95dff043767e26c5533e62eb78f608b')
    short = bit.shorten(url)
    short.short_url
  end
end
