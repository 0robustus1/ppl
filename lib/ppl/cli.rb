
require "ppl"

class Ppl::CLI

  def initialize(arguments=[])
    @arguments = arguments
    @address_book = Ppl::Address_Book.new("/home/h2s/doc/contacts")
    @commands  = commands
  end

  def run
    command_name = @arguments.shift
    command      = find_command command_name

    if command.nil?
      command = find_command "help"
    end

    command.send "execute"
  end

  private

  def commands
    @commands = []
    Ppl::Command.constants.each do |name|
      constant = Ppl::Command.const_get(name)
      command = constant.new(@arguments, {}, @address_book)
      @commands.push command
    end
    @commands.sort! { |a,b| a.name <=> b.name }
  end

  def find_command(name)
    matches = @commands.select { |command| command.name == name }
    matches.first
  end

end

