class GamesController < ApplicationController

  # POST /games
  def create
    @game = current_user.games.new

    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # POST /games/move
  def move
    @game = Game.find(params[:game_id])

    guess = params[:guess]

    @game.guess(guess)

    if @game.save
      render json: @game, status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private
end
