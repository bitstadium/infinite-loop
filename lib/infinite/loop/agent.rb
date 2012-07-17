require "json"
require "rest-client"

module Infinite
  module Loop
    class Agent
      BASE_URL = "https://rink.hockeyapp.net/api/2/"

      def initialize
        netrc = Netrc.read
        @token = netrc[Infinite::HOSTNAME].first unless netrc[Infinite::HOSTNAME].nil?
      end

      def list_apps(release_type_string = nil)
        response = RestClient.get "#{BASE_URL}apps", { "X-HockeyAppToken" => @token }
        apps = JSON.parse(response)["apps"]
        apps.reject! { |app| app["release_type"] != release_type(release_type_string) } unless release_type_string.nil?
        apps
      end

      def list_devices(app_id, unprovisioned = nil)
        response = RestClient.get "#{BASE_URL}apps/#{app_id}/devices?unprovisioned=#{unprovisioned.to_s == "unprovisioned" ? 1 : 0}", {"X-HockeyAppToken" => @token }
        devices = JSON.parse(response)["devices"]
        devices
      end

      def list_tokens(user, pass)
        response = RestClient::Request.new(:method => :get, :url => "#{BASE_URL}auth_tokens", :user => user, :password => pass).execute
        tokens = JSON.parse(response.to_str)["tokens"]
        tokens
      end

      def create_token(user, pass)
        response = RestClient::Request.new(:method => :post, :url => "#{BASE_URL}auth_tokens", :user => user, :password => pass).execute
        tokens = JSON.parse(response.to_str)["tokens"]
        tokens
      end

      def release_type(string)
        case string
        when "beta"
          0
        when "live"
          1
        when "alpha"
          2
        end
      end

      def release_type_string(value)
        case value.to_i
        when 0
          "beta"
        when 1
          "live" 
        when 2
          "alpha"
        end
      end
    end
  end
end