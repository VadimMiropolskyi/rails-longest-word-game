require 'open-uri'
require 'json'

class GamesController < ApplicationController
    def new
        alphabet = ('A'..'Z').to_a
        @letters = Array.new(10) { alphabet.sample }
    end

    def score
        word = params[:word]
        letters = params[:letters].split(' ')

        if word.upcase.chars.all? { |char| letters.include?(char) }
            url = "https://wagon-dictionary.herokuapp.com/#{word}"
            response = URI.open(url).read
            result = JSON.parse(response)
            if result['found']
                @score = "Congratulations! #{word} is a valid English word!"
            else
                @score = "#{word} is not a valid English word."
            end
        else
            @score = "#{word} can't be built out of the original grid."
        end
    end
end
