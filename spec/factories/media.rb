# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium, :class => 'Media' do
    post_id 1
    video false
    url "MyString"
    picture "MyString"
  end
end
