#!/usr/bin/env ruby

class RndNick
  attr_reader :nick_alphabet, :password_alhpabet, :nick, :password
  
  NICK_ALPHABET_SIZE = 7
  PASSWORD_SIZE = 15

  def initialize
    @nick_alphabet = ('a'..'z').to_a
    @password_alhpabet = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ('!'..'?').to_a
    @nick = ''
    @password = ''
  end 

  def display_nick 
    puts "\nlogin: #{@nick}"
  end 

  def display_password  
    puts "password: #{@password}\n\n"
  end 

  def perform 
    generate_rnd_nick
    generate_rnd_passwd
    display_nick
    display_password
  end

  private 

  def generate_rnd_nick
    NICK_ALPHABET_SIZE.times { |i| @nick << nick_alphabet.sample } 
  end

  def generate_rnd_passwd
    PASSWORD_SIZE.times { |i| @password << password_alhpabet.sample } 
  end
end

RndNick.new.perform