require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
   i = 0
   @array = []
   while i < 10
    random_letter = ('A'..'Z').to_a.sample
    i += 1
    @array << random_letter
  end
  @array
end

def score
  @word = params[:word]
  @grid = params[:grid]
  arrayed_attempt = @word.upcase.chars
  grid_array = @grid.chars
  word_serialized = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
  word_found = JSON.parse(word_serialized)
  if arrayed_attempt.all? { |letter| grid_array.count(letter) >= arrayed_attempt.count(letter) }
    @score = "WHAAAAT"
    if word_found["found"]
      @score = "#{@word} is a valid English word! YOU DID IT"
    else
      @score = "#{@word} is not a valid English word"
    end
  else
    @score = "Sorry but #{@word} can't be built out of #{@grid}"
  end
end

end

