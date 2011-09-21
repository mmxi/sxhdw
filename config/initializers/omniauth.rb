require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, OpenID::Store::Filesystem.new("/tmp"), :name => "google", :identifier => "https://www.google.com/accounts/o8/id"
  provider :douban , '0a7439375f5c761e1f5caba61e15625a', '850e5835846c77a9'
  provider :tsina, '472825844', 'e8821a8cc3f2e06fa81decf67b755175'
  provider :tqq, '978754fc940143458af4d72c9580e6ac', 'cff1d1510beb898dd54980bfcf66e58c'
  provider  :renren, 'a2c525a5427b4939b247bba7ce2a43bd', '4624982986f94e79a27f83e1e60381ce'
  provider  :qzone, '221342', 'f8b7879dc541045ea43669082b2bb5da'
end