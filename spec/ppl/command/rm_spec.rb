
describe Ppl::Command::Rm do

  before(:each) do
    @command = Ppl::Command::Rm.new
    @input   = Ppl::Application::Input.new
    @output  = Ppl::Application::Output.new(nil, nil)
    @contact = Ppl::Entity::Contact.new
    @storage = double(Ppl::Adapter::Storage)

    @input.arguments = ["test"]
    @command.storage = @storage
  end

  describe "#name" do
    it "should be 'rm'" do
      @command.name.should eq "rm"
    end
  end

  describe "#execute" do

    it "should raise an error if the contact isn't specified" do
      @input.arguments = [nil]
      expect{@command.execute(@input, @output)}.to raise_error(Ppl::Error::IncorrectUsage)
    end

    it "should delete the given contact" do
      @storage.should_receive(:require_contact).and_return(@contact)
      @storage.should_receive(:delete_contact).with(@contact)
      @command.execute(@input, @output)
    end

  end

end

