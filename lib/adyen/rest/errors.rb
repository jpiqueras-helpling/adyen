module Adyen
  module REST

    # The main exception class for error reporting when using the REST API Client.
    class Error < Adyen::Error
    end

    # Exception class for errors on requests
    class RequestValidationFailed < Adyen::REST::Error
    end

    # Exception class for error responses from the Adyen API.
    #
    # @!attribute status
    #    @return [String, nil]
    # @!attribute error_code
    #    @return [Integer, nil]
    # @!attribute message
    #    @return [String, nil]
    # @!attribute error_type
    #    @return [String, nil]
    # @!attribute psp_reference
    #    @return [String, nil]
    class ResponseError < Adyen::REST::Error
      attr_reader :status, :error_code, :message, :error_type, :psp_reference

      def initialize(response_body)
        parse_params(response_body)
        if error_code && message && error_type
          super("API request error: #{message} (code: #{error_type}/#{error_code})")
        else
          super("API request error: #{response_body}")
        end
      end

      private

      def parse_params(response_body)
        params = Hash[CGI.parse(response_body).map {|key,values| [key.to_sym, values[0] || true]}]
        @status = params[:status]
        @error_code = params[:errorCode]
        @message = params[:message]
        @error_type = params[:errorType]
        @psp_reference = params[:pspReference] if params[:pspReference]
      end
    end
  end
end
