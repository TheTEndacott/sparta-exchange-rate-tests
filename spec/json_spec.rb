require_relative 'spec_helper'

describe "Creating tests for currency json file" do

  before (:each) do
    @currency = ParseJSON.new("json_exchange_rates.json")
  end

  it "should have base currency of EUR (euros)" do
    expect(@currency.json_file["base"]).to eq("EUR")
  end

  it "should have a total of 31 currencies" do
    expect(@currency.json_file["rates"].length).to eq(31)
  end

  it "should have IDR at less than 20000" do
    expect(@currency.json_file["rates"]["IDR"]).to be < 20000
  end

  it "should have GBP less than CAD" do
    expect(@currency.json_file["rates"]["GBP"]).to be < (@currency.json_file["rates"]["CAD"])
  end

  it "should include NOK" do
    expect(@currency.json_file["rates"]).to include("NOK")
  end

  it "should have AUD as the first currency" do
    expect(@currency.json_file["rates"].first).to include("AUD")
  end

  it "should be out of date data by having the year be 2017" do
    expect(@currency.json_file["date"]).to include("2017")
  end

  it "should confirm that all data types are floats" do
    expect(@currency.json_file["rates"].values).to all(be_a(Float))
  end

  # should fail as an example
  it "should have SEK greater than or equal to 10" do
    expect(@currency.json_file["rates"]["SEK"]).to be >= 10
  end

end