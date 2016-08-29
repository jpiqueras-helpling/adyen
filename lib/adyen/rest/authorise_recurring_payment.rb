module Adyen
  module REST

    # This modules implements the recurring requests using<b>Payment.authorise</b> by subclassing Adyen::REST::AuthorisePayment::Request it only adds mandatory fields to it
    # Those requests can be called using #Adyen::Rest::AuthorisePayment.authorise_recurring_payment and #Adyen::Rest::AuthorisePayment.reauthorise_recurring_payment
    module AuthoriseRecurringPayment
      class Request < Adyen::REST::AuthorisePayment::Request
        def initialize(action, attributes, options)
          attributes[:recurring] ||= { contract: 'RECURRING' }
          super(action, attributes, options)
          @required_attributes += ['shopperEmail',
            'recurring.contract',
            'shopperReference',
          ]
        end
      end
    end

    module ReauthoriseRecurringPayment
      class Request < Adyen::REST::AuthorisePayment::Request
        def initialize(action, attributes, options)
          attributes[:recurring] ||= { contract: 'RECURRING' }
          attributes[:shopper_interaction] ||= 'ContAuth'
          attributes[:selected_recurring_detail_reference] ||= 'LATEST'
          super(action, attributes, options)
          @required_attributes += ['shopperEmail',
            'shopperReference',
            'recurring.contract',
            'shopperInteraction'
          ]
        end
      end
    end

    module ListRecurringDetailsPayment
      class Request < Adyen::REST::Request
        def initialize(action, attributes, options)
          attributes[:recurring] ||= { contract: 'RECURRING' }
          super(action, attributes, options)
          @required_attributes += ['recurring.contract',
            'shopperReference']
        end
      end
    end
  end
end
