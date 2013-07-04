require 'action_view'
require 'dm-migrations'
require 'dm-validations'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db.sqlite3")

include ActionView::Helpers::DateHelper


class User 
  include DataMapper::Resource

  attr_accessor :password_confirmation

  property :id,         Serial# primary serial key
  property :username,   String, :required => true, :unique => true
  property :password,   String, :required => true
  property :avatar_url, String
  property :email,      String, :required => true, :unique => true,
           :format   => :email_address,
           :messages => { :presence  => "We need your email address.",
           :is_unique => "We already have that email.",
           :format    => "Doesn't look like an email address to me ..."}
  property :created_at, DateTime
  property :updated_at, DateTime
  validates_length_of :username, :within => 4..20,
                       :message => "Username must be between 4 to 20 characters"
  validates_length_of :password, :min => 6,
                       :message => "Password is too short (minimum is 6 characters)"
  validates_confirmation_of :password, :confirm => :password_confirmation

  has n, :pets
  has n, :photos
  has n, :galleries
  has n, :chat_messages
end


class Pet
  include DataMapper::Resource

  property :id,     Serial
  property :name,   String

  belongs_to :user
  belongs_to :breed, :required => false
  belongs_to :animal, :required => false


end

class Breed
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

end

class CatBreed
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

end

class DogBreed
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

end
class HorseBreed
  include DataMapper::Resource

  property :id,   Serial
  property :name, String

end
class ChatMessage
  include DataMapper::Resource

  property :id, Serial
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :from_user, 'User'
  belongs_to :to_user, 'User'
end

class Photo
  include DataMapper::Resource

  property :id,        Serial
  property :filename, String
  property :title,     String
  property :created_at, DateTime
  property :updated_at, DateTime

  def url
    "/files/#{self.filename}"
  end

  def thumb_url
    "/files/thumb_#{self.filename}"
  end

  def created_ago
   time_ago_in_words(self.created_at)
  end

  belongs_to :gallery, :required => false
  belongs_to :user, :required => false
end

class Message
  include DataMapper::Resource
  property :id, Serial
  property :body, Text
  property :created_at, DateTime
  belongs_to :from_user, 'User'
  belongs_to :to_user, 'User'
end

class City 
  include DataMapper::Resource

  property :id, Serial
  property :name, String 
  has n, :advertisement_messages
end

class Animal 
  include DataMapper::Resource

  property :id, Serial
  property :name, String 
  has n, :advertisement_messages
end

class ClassifiedCategory
  include DataMapper::Resource

  property :id, Serial
  property :name, String
end

class AdvertisementMessage
  include DataMapper::Resource

  property :id, Serial
  property :url, String
  property :thumb_url, String
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :user
  belongs_to :city, :required => false
  belongs_to :animal, :required => false
  belongs_to :gallery, :required => false
  belongs_to :classified_category, :require => false
end

class Gallery
  include DataMapper::Resource

  property :id,        Serial
  property :title,     String

  has n, :photos
  belongs_to :cover, 'Photo'
  belongs_to :user
end


DataMapper.finalize
DataMapper.auto_migrate!
#DataMapper.auto_upgrade!
