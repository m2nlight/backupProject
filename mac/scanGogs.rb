#!/usr/bin/env ruby
require 'open-uri'
require 'thread'
require 'english'

# config
CONFIG_IPDOMAIN = '192.168.10.'.freeze
CONFIG_RANGE = (2..254)
CONFIG_URITEMPLATE = 'http://%s:3000/user/login'.freeze

# tty
TTY_FG = { Black: 30, Red: 31, Green: 32, Yellow: 33, Blue: 34,
           Magenta: 35, Cyan: 36, White: 37 }.freeze
TTY_BG = { Black: 40, Red: 41, Green: 42, Yellow: 43, Blue: 44,
           Magenta: 45, Cyan: 46, White: 47 }.freeze
TTY_MD = { Reset: 0, Bold: 1, Italics: 3, Underlined: 4 }.freeze

def tty_msg(msg, tty_fg: nil, tty_bg: nil, tty_md: nil)
  "\033[#{TTY_MD[tty_md]};#{TTY_FG[tty_fg]};#{TTY_BG[tty_bg]}m#{msg}\033[0m"
end

# tty styles
def note_style(msg)
  tty_msg(msg, tty_fg: :Yellow, tty_md: :Underlined)
end

def yes_style(msg)
  tty_msg(msg, tty_fg: :Black, tty_md: :Bold, tty_bg: :Green)
end

def error_style(msg)
  tty_msg(msg, tty_fg: :White, tty_bg: :Red)
end

# main
puts note_style('Working...')
success_list = []
threads = []
CONFIG_RANGE.each do |n|
  threads << Thread.new do
    s = CONFIG_IPDOMAIN + String(n)
    uri = format(CONFIG_URITEMPLATE, s)
    begin
      open(uri)
      s << "\t" << yes_style('**YES**')
      success_list << uri
    rescue
      s << "\t" << error_style('error') << " #{$ERROR_INFO}\n"
    end
    puts s
  end
end

threads.each(&:join)
puts note_style('Result:')
success_list.each { |s| puts s }
