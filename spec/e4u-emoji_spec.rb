# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe E4U::Emoji do
  it "createでインスタンスが作れること" do
    [:docomo,
     :kddi, :au,
     :softbank, :iphone,
     :google, ].each do |carrier|
      emj = E4U.create(carrier)
      emj.should be_instance_of E4U::Emoji
    end
  end

  it "createで例外が起こること" do
    lambda{ E4U.create :emobile }.should raise_error(ArgumentError)
  end

  it "black_sun_with_raysでUTF8が返ること" do
    { :docomo   => [0xE63E].pack("U"),
      :kddi     => [0xE488].pack("U"),
      :au       => [0xE488].pack("U"),
      :softbank => [0xE04A].pack("U"),
      :iphone   => [0xE04A].pack("U"),
      :google   => [0xFE000].pack("U"),
    }.each do |carrier, expect|
      emj = E4U.create carrier
      emj.black_sun_with_rays.should == expect
    end
  end
end
