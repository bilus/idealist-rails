CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAIXU4SNTHHYEODCBQ', # TODO: Use ENV.
    aws_secret_access_key: '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'
  }
  config.fog_directory = 'images-ideas'
end