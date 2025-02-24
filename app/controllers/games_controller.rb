class GamesController < ApplicationController
  require 'net/http'
  require 'json'

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def word_in_dictionary(word)
    url = URI("https://dictionary.lewagon.com/#{word}")
    answer = Net::HTTP.get(url)
    parsed_answer = JSON.parse(answer)
    if !parsed_answer[found: true]
      return
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  # def word_in_grid
  #   @word.chars.sort.all? { |letter| @letters.include?(letter) }
  # end

  def score
    @score = 0
    @word = params[:word].upcase
    @letters = params[:letters].upcase
    if included?(@word, @letters)
      if word_in_dictionary(@word)
        @message = 'Well done!'
      else
        @message = 'Sorry, your word is not English.'
      end
    else
      @message = "Sorry, your word is not valid."
    end
  end

    # elsif !word_in_dictionary
    #   @message = "Sorry, that word isn't in the dictionary. Your score is #{@score}."
    # else
    #   @score = 5
    #   @message = "Well played! Your score is #{@score}."
    # end


    # recuperer @letters (comment recuperer d'une vue au controller)
    # 1. prendre @word et verifier que chaque lettre utilisee est incluse dans @letters - A
    # 1.1 if false
    # 1.2 if true, is the word in the dictionary?
    # 1.3 if false
    # 1.4 if true, le mot inclut les lettres et est anglais. You won. Score = 5
end
