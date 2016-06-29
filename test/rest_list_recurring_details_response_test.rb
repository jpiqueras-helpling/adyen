require 'test_helper'
require 'adyen/rest'

class ListRecurringDetailsResponse < Minitest::Test

  def setup
    @http_response = mock
    @recurring_detail_reference = "8314231570619177"
    @body = "shopperReference=lup%40lup.com%23555&details.0.variant=mc&details.0.card.number=1111&details.0.recurringDetailReference=#{@recurring_detail_reference}&details.0.card.expiryMonth=6&creationDate=2015-02-05T18%3A24%3A21%2B01%3A00&lastKnownShopperEmail=lup%40lup.com&details.0.creationDate=2015-02-05T18%3A24%3A21%2B01%3A00&details.0.card.expiryYear=2016&details.0.card.holderName=jose"
    @expected_details = [{ recurring_detail_reference: @recurring_detail_reference, creation_date: "2015-02-05T18:24:21+01:00", variant: "mc", card_holder_name: "jose", card_expiry_month: "6", card_expiry_year: "2016", card_number: "1111" }]
    @http_response.stubs(body: @body)
    @response = Adyen::REST::AuthorisePayment::ListRecurringDetailsResponse.new(@http_response)
  end

  def test_getting_details
    assert_equal @response.details, @expected_details
  end

  def test_getting_references
    assert_equal @response.references, [@recurring_detail_reference]
  end
end
