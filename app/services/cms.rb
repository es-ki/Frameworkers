require "net/http"
require "uri"
require "json"

class Cms
  ENDPOINTS = {
    frameworks: "frameworks",
    tags: "tags"
  }.freeze

  class << self
    def fetch_framework(id)
      fetch_content(ENDPOINTS[:frameworks], id)
    end
    def fetch_frameworks(query)
      fetch_contents(ENDPOINTS[:frameworks], query)
    end

    def fetch_tag(id)
      fetch_content(ENDPOINTS[:tags], id)
    end
    def fetch_tags(query)
      fetch_contents(ENDPOINTS[:tags], query)
    end

    private

    def base_url
      "https://#{ENV['MICROCMS_SERVICE_DOMAIN']}.microcms.io/api/v1"
    end

    def headers
      { 'X-MICROCMS-API-KEY': ENV["MICROCMS_API_KEY"] }
    end

    def fetch_content(endpoint, id)
      uri = URI.parse("#{base_url}/#{endpoint}/#{id}")
      handle_response(Net::HTTP.get_response(uri, headers), "#{endpoint}}単一コンテンツ取得")
    end

    def fetch_contents(endpoint, query = nil)
      uri = URI.parse("#{base_url}/#{endpoint}#{query ? "?#{query}" : ""}")
      handle_response(Net::HTTP.get_response(uri, headers), "#{endpoint}複数コンテンツ取得")
    end

    def handle_response(response, context)
      case response.code.to_i
      when 200
        JSON.parse(response.body)
      when 404
        raise ActiveRecord::RecordNotFound
      else
        raise StandardError
      end
    rescue ActiveRecord::RecordNotFound => e
      ErrorUtility.logger(e, context)
      raise
    rescue StandardError => e
      ErrorUtility.logger(e, "予期せぬエラー")
      raise
    end
  end
end
