require 'spec_helper'

describe "Home pages" do
  subject { page }
  describe "index page" do
    before { visit root_path }
    it { should have_content('to test') }
    it { should have_title("An Artist's War") }
    it { should_not have_title('| Home') }
  end
end
