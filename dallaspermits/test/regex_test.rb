require File.expand_path('../regex')
require 'test/unit'

class RegexTest < Test::Unit::TestCase
	def test_DATE_LOOSE
		date = '1/1/2001'
		assert(date.match(Regex::DATE_LOOSE))
		date = '01/01/2001'
		assert(date.match(Regex::DATE_LOOSE))
		date = '2/9/2006 14:44:58'
		assert(date.match(Regex::DATE_LOOSE))
		date = '2/9/2006 14:44'
		assert(date.match(Regex::DATE_LOOSE))
		date = '01/01/01'
		assert(!date.match(Regex::DATE_LOOSE))
	end

	def test_DOLLAR_CURRENCY
		amount = "$1"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$1.00"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$10"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$1000000000"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$500,000"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$1,000,000,000"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "$1,234,567,890,123.45"
		assert(amount.match(Regex::DOLLAR_CURRENCY))
		amount = "1"
		assert(!amount.match(Regex::DOLLAR_CURRENCY))
		amount = "1,234,567,890,123.45"
		assert(!amount.match(Regex::DOLLAR_CURRENCY))
	end
end

