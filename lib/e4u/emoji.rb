require 'e4u/emoji/docomo'
require 'e4u/emoji/kddi'
require 'e4u/emoji/softbank'
require 'e4u/emoji/google'

module E4U
  @emoji = {}
  def self.create carrier
    carrier = :kddi if carrier == :au
    carrier = :softbank if carrier == :iphone
    @emoji[carrier] ||= Emoji.new(carrier)
  end

  class Emoji
    def initialize carrier
      @table = case carrier
               when :docomo
                 DOCOMO_TABLE
               when :au, :kddi
                 KDDI_TABLE
               when :softbank, :iphone
                 SOFTBANK_TABLE
               when :google
                 GOOGLE_TABLE
               else
                 raise ArgumentError
               end
    end

    def method_missing method, *args
      raise NoMethodError unless @table[method]
      @table[method]
    end
  end
end
