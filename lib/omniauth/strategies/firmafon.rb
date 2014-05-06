require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Firmafon < OmniAuth::Strategies::OAuth2

			option :name, :firmafon
			option :provider_ignores_state, true

			option :client_options, {
				:site => 'https://app.firmafon.dk',
				:authorize_url => '/api/v2/authorize',
				:token_url => '/api/v2/token',
				:provider_ignores_state => true
			}

			uid { raw_info['id'] }

			info do
				{
					:name => raw_info['name'],
					:email => raw_info['email']
				}
			end

			extra do
				raw_info
			end

			def raw_info
				@raw_info ||= access_token.get('/api/v2/employee.json').parsed['employee']
			end

    end
  end
end
