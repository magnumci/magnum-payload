module Magnum
  module Payload::MessageParser
    REGEX_SKIP = /\[(ci skip|ci-skip|skip ci|skip-ci)\]/i

    def skip_message?
      message.to_s.split("\n").first =~ REGEX_SKIP ? true : false
    end
  end
end