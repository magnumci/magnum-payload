module Magnum
  module Payload
    class Error        < StandardError ; end
    class ParseError   < Error         ; end
    class PayloadError < Error         ; end
  end
end