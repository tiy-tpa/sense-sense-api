class MasterMind
  PEG_COLORS = %w{green aqua fuschia blueberry fire coal}

  attr_accessor :secret, :moves

  def initialize(secret = nil)
    @secret = secret || PEG_COLORS.shuffle.take(4)
    @moves = []
  end

  # How many guesses have we done?
  def guess_count
    moves.length
  end

  # boolean, true if this result is a `win`
  def result_win?(result)
    result == [:exact_match]*4
  end

  # Make a guess, guess should be an Array
  # of four colors. The colors should be Strings
  # from PEG_COLORS
  #
  # Returns an array of four symbols, one for each
  # peg color supplied in the guess argument.
  #
  # If that color was correct *and* in the right
  # position, the value will be :exact_match. If
  # the color is correct but the position is wrong
  # the value will be :inexact_match. If the color
  # is totally wrong, the value will be :miss
  #
  # Example:
  #
  # ruby mastermind.rb
  #
  # The Game's secret is ["Pink", "Green", "Blue", "Purple"]
  # And when guessing ["Red", "Green", "Green", "Blue"]
  # the result is [:exact_match, :inexact_match, :miss, :miss]
  def guess(guess)
    secret_dup = @secret.dup
    guess_dup  = guess.dup

    result = []

    (guess_dup.length - 1).downto(0).each do |index|
      if guess_dup[index] == secret_dup[index]
        result << :exact_match
        guess_dup.delete_at(index)
        secret_dup.delete_at(index)
      end
    end

    (guess_dup.length - 1).downto(0).each do |index|
      position = secret_dup.index(guess_dup[index])
      if position
        result << :inexact_match

        secret_dup.delete_at(position)
        guess_dup.delete_at(index)
      end
    end

    guess_dup.each do |index|
      result << :miss
    end

    moves << { "guess" => guess, "result" => result.sort }

    result
  end
end

# This code allows us to run what is inside the
# if statement if you run this script directly
# (e.g. ruby mastermind.rb)
#
# Otherwise when `require_relative` this code
# this doesn't run.
#
# This lets you "test out" the MasterMind class
# to see if you understand how it works.
#
if $0 == __FILE__
  require 'minitest/autorun'

  describe MasterMind do
    it "should show four misses if no entries match" do
      game = MasterMind.new(%w{Blue Blue Blue Blue})

      result = game.guess(%w{Green Green Green Green})

      assert_equal [:miss, :miss, :miss, :miss], result
    end

    it "should show one exact match if only one matches" do
      game = MasterMind.new(%w{Red Green Blue Orange})

      result = game.guess(%w{Green Green Green Green})

      assert_equal [:exact_match, :miss, :miss, :miss], result
    end

    it "should show two exact matches" do
      game = MasterMind.new(%w{Red Green Green Orange})

      result = game.guess(%w{Green Green Green Green})

      assert_equal [:exact_match, :exact_match, :miss, :miss], result
    end

    it "should show two exact matches and one inexact match" do
      game = MasterMind.new(%w{Red Green Green Orange})

      result = game.guess(%w{Orange Green Green Green})

      assert_equal [:exact_match, :exact_match, :inexact_match, :miss], result
    end

    it "should show inexact matches" do
      game = MasterMind.new(%w{Red Green Blue Orange})

      result = game.guess(%w{Orange Blue Green Red})

      assert_equal [:inexact_match, :inexact_match, :inexact_match, :inexact_match], result
    end
  end
end
