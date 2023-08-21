# frozen_string_literal: true
require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letter = ('a'...'z').to_a.sample
      @letters << @letter
    end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @score = if included?(@word, @letters)
               if english_word?(@word)
                 'Well done!'
               else
                 'Not an english word'
               end
             else
               'Not in the grid'
             end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
