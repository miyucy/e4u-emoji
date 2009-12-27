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

  it "DoCoMo絵文字で複合絵文字を返すこと" do
    E4U.create(:docomo).love_hotel.should_not == [0xE669,0xE6EF].pack('U')
    E4U.create(:docomo).sun_behind_cloud.should_not == [0xE63E,0xE63F].pack('U')

    E4U.create(:docomo).love_hotel.should == [0xE669,0xE6EF].pack('U*')
    E4U.create(:docomo).sun_behind_cloud.should == [0xE63E,0xE63F].pack('U*')
  end

  it "KDDI絵文字で複合絵文字を返すこと" do
    E4U.create(:kddi).happy_face_with_open_mouth_and_cold_sweat.should_not == [0xE471,0xE5B1].pack('U')

    E4U.create(:kddi).happy_face_with_open_mouth_and_cold_sweat.should == [0xE471,0xE5B1].pack('U*')
  end

  it "Softbank絵文字で複合絵文字を返すこと" do
    E4U.create(:softbank).happy_face_with_open_mouth_and_cold_sweat.should_not == [0xE415,0xE331].pack('U')
    E4U.create(:softbank).love_letter.should_not == [0xE103,0xE328].pack('U')
    E4U.create(:softbank).sun_behind_cloud.should_not == [0xE04A,0xE049].pack('U')

    E4U.create(:softbank).happy_face_with_open_mouth_and_cold_sweat.should == [0xE415,0xE331].pack('U*')
    E4U.create(:softbank).love_letter.should == [0xE103,0xE328].pack('U*')
    E4U.create(:softbank).sun_behind_cloud.should == [0xE04A,0xE049].pack('U*')
  end

  it "DoCoMo絵文字データがfreezeされていること" do
    E4U::Emoji::DOCOMO_TABLE.all?{ |e| e[1].frozen? }.should be_true
  end

  it "KDDI絵文字データがfreezeされていること" do
    E4U::Emoji::KDDI_TABLE.all?{ |e| e[1].frozen? }.should be_true
  end

  it "Softbank絵文字データがfreezeされていること" do
    E4U::Emoji::SOFTBANK_TABLE.all?{ |e| e[1].frozen? }.should be_true
  end

  it "Google絵文字データがfreezeされていること" do
    E4U::Emoji::GOOGLE_TABLE.all?{ |e| e[1].frozen? }.should be_true
  end
end
