class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_characters = @word.chomp.downcase.split(//)
  end
  
  def guess(letter)
    if (letter =~ /\W/i || letter == '' || letter.nil?)
      raise ArgumentError
    elsif @word.include?(letter.downcase) && !(@guesses.include?(letter.downcase))
      @guesses.insert(-1,letter.downcase)
    elsif !(@word.include?(letter.downcase)) && !(@wrong_guesses.include?(letter.downcase))
      @wrong_guesses.insert(-1,letter.downcase)
    else
      false
    end
  end
  
  def word_with_guesses
    return word.gsub(/[^#{guesses}]/,"-") if @guesses.length > 0
    return "-" * word.length
  end
  
  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
