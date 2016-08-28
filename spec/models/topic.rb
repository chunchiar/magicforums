require 'rails_helper'

RSpec.describe Topic, type: :model do

  context "assocation" do
  it { should have_many(:posts) }
end

  context "title length validation" do
  it { should validate_length_of(5) }
end

  context "description length validation" do
  it { should validate_length_of(10) }
end

  context "slug callback" do
   it "should set slug" do
     topic = create(:topic)

     expect(topic.slug).to eql(topic.title.gsub(" ", "-"))
   end

   it "should update slug" do
     topic = create(:topic)

     topic.update(title: "updatedtopic")

     expect(topic.slug).to eql("updatedtopic")
   end
  end

end
