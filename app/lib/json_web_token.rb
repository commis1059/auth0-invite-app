# frozen_string_literal: true

require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(token, nil,
               true,
               algorithm: 'RS256',
               iss: "https://#{ENV.fetch('AUTH_ISS')}/",
               verify_iss: true,
               aud: Rails.env.production? ? Rails.application.secrets.auth_aud : ENV.fetch("AUTH_AUD"),
               verify_aud: true) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI("https://#{ENV.fetch('AUTH_ISS')}/.well-known/jwks.json")
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    Hash[
      jwks_keys
        .map do |k|
        [
          k['kid'],
          OpenSSL::X509::Certificate.new(
            Base64.decode64(k['x5c'].first)
          ).public_key
        ]
      end
    ]
  end
end
