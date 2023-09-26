# frozen_string_literal: true

require "base64"

module Base64Utils
  def self.encoding_to_base64(buffer)
    b64buffer = Base64.strict_encode64(buffer.pack("C*"))
    b64buffer.force_encoding("UTF-8")
  rescue StandardError => e
    raise e
  end

  def self.decoding_from_base64(base64)
    buffer = base64.encode("UTF-8")
    Base64.strict_decode64(buffer).bytes
  rescue StandardError => e
    raise e
  end
end
