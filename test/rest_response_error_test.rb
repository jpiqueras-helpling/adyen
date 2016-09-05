require 'test_helper'
require 'adyen/rest/errors'

class RESTResponseErrorTest < Minitest::Test

  def test_parsing_attributes
    response_body = 'errorType=validation&errorCode=800&message=Contract+not+found&pspReference=1234512345&status=422'
    response_error = Adyen::REST::ResponseError.new(response_body)
    common_checks(response_error)
    assert_equal '1234512345', response_error.psp_reference
  end

  def test_parsing_attributes_without_psp_reference
    response_body = 'errorType=validation&errorCode=800&message=Contract+not+found&status=422'
    response_error = Adyen::REST::ResponseError.new(response_body)
    common_checks(response_error)
    assert_nil response_error.psp_reference
  end

  def common_checks(response_error)
    assert_equal '422', response_error.status
    assert_equal 'validation', response_error.error_type
    assert_equal '800', response_error.error_code
    assert_equal 'Contract not found', response_error.message
  end
end
