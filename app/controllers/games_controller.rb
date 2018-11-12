require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << Array('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    letters = params[:letters]
    if @word.upcase.chars.all? { |x| @word.upcase.count(x) <= letters.count(x) }
      if english_word(@word) == true
        @score = "Congratulations #{@word} is an English word!"
      else
        @score = "#{@word} it's not a english word"
      end
    else
      @score = "#{@word} can't be build out of : #{letters}"
    end
  end

  private

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    html_file = open(url).read
    dictionary = JSON.parse(html_file)
    return dictionary['found']
  end

end
