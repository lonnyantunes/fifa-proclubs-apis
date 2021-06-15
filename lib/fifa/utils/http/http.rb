module Fifa
  module Utils
    module HTTP
      class << self
        def get(url, options = {})
          execute(url, options)
        end

        def post(url, options = {method: :post})
          execute(url, options)
        end

        def patch(url, options = {method: :patch})
          execute(url, options)
        end

        def delete(url, options = {method: :delete})
          execute(url, options)
        end

        protected

        def proxy
          http_proxy = ENV['http_proxy']
          begin
            URI.parse(http_proxy)
          rescue
            nil
          end
        end

        def to_uri(url, params = {})
          begin
            url = URI.parse(url) unless url.is_a?(URI)
          rescue
            raise URI::InvalidURIError, "Invalid url '#{url}'"
          end

          if url.class != URI::HTTP && url.class != URI::HTTPS
            raise URI::InvalidURIError, "Invalid url '#{url}'"
          end

          url.query = URI.encode_www_form(params)

          url
        end

        def execute(url, options = {})
          options = {parameters: {}, json_body: {},
                     http_timeout: 60, method: :get,
                     headers: {}, redirect_count: 0,
                     max_redirects: 10}.merge(options)

          Log.method_arguments_values(self, __method__, binding)

          url = to_uri(url, options[:parameters])

          http = if proxy
                   Net::HTTP::Proxy(proxy.host, proxy.port).new(url.host, url.port)
                 else
                   Net::HTTP.new(url.host, url.port)
                 end

          if url.scheme == 'https'
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end

          http.open_timeout = http.read_timeout = options[:http_timeout]
          http.set_debug_output $stderr if Environment::Helper.verbose?

          request = case options[:method]
                    when :post
                      get_request(options, url, Net::HTTP::Post)
                    when :patch
                      get_request(options, url, Net::HTTP::Patch)
                    when :delete
                      get_request(options, url, Net::HTTP::Delete)
                    else
                      Net::HTTP::Get.new(url.request_uri)
                    end

          options[:headers].each { |key, value| request[key] = value }

          response = http.request(request)

          if response.is_a?(Net::HTTPRedirection)
            options[:redirect_count] += 1

            if options[:redirect_count] > options[:max_redirects]
              raise "Too many redirects (#{options[:redirect_count]}): #{url}"
            end

            redirect_url = redirect_url(response)

            if redirect_url.start_with?('/')
              url = to_uri("#{url.scheme}://#{url.host}#{redirect_url}")
            end

            response = execute(url, options)
          end

          http_response_to_own(response)
        end

        # From http://railstips.org/blog/archives/2009/03/04/following-redirects-with-nethttp/
        def redirect_url(response)
          if response['location'].nil?
            response.body.match(/<a href="([^>]+)">/i)[1]
          else
            response['location']
          end
        end

        def http_response_to_own(http_response)
          own_response = Response.new(http_response.code.to_i, http_response.body)
          if own_response.code == 200 || own_response.code == 201
            own_response.body =
              begin
                JSON.parse(own_response.body.force_encoding(Encoding::UTF_8))
              rescue Exception => e
                own_response.body.force_encoding(Encoding::UTF_8)
              end
          end

          Log.verbose(self, __method__, own_response.code, 'response code')
          Log.verbose(self, __method__, own_response.body, 'response body')

          own_response
        end

        private

        def get_request(options, url, http_request_method)
          request = http_request_method.new(url.request_uri, 'Content-Type' => 'application/json')
          request.set_form_data(options[:parameters])

          request.body = options[:json_body] unless options[:json_body].empty?

          request
        end

      end
    end
  end
end
