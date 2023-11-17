# frozen_string_literal: true

require "digest"
require "base64"

module MD5Utils
  def self.encrypt(data_str)
    m = Digest::MD5.new
    m.update(data_str.encode("UTF-8"))
    s = m.digest
    result = ""

    s.each_byte do |byte|
      result += (byte & 0xFF | -256).to_s(16)[6..-1]
    end

    result
  rescue StandardError => e
    e.backtrace
    ""
  end

  def self.hash_mac(data, secret)
    kd_mac = OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), secret, data)
    hex_string = bytes_to_hex(kd_mac.bytes)
    Base64.strict_encode64(hex_string)
  rescue StandardError => e
    e.backtrace
    nil
  end

  def self.bytes_to_hex(bytes)
    bytes.map { |byte| byte.to_s(16).rjust(2, "0") }.join
  end
end
