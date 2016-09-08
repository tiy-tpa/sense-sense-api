class Game < ApplicationRecord
  belongs_to :user

  serialize :moves, JSON
  serialize :secret, JSON

  before_create :ensure_moves_and_secret

  def as_json(options=nil)
    super(options.merge(except: [:secret]))
  end

  def guess(guess)
    # Reconstitue a MasterMind object
    mastermind = MasterMind.new(secret)
    mastermind.moves = moves

    # Make a guess
    mastermind.guess(guess)

    # Save off the moves
    self.moves = mastermind.moves
  end

private

  def ensure_moves_and_secret
    mastermind = MasterMind.new

    self.secret = mastermind.secret
    self.moves = []
  end
end
