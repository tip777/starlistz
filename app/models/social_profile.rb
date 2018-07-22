class SocialProfile < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :uid

  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
    info = omniauth['info']
    raw_info = omniauth['extra']['raw_info']
    self.email = info['email']
    self.name = info['name']
    self.nickname = info['nickname']
    self.followers_count = raw_info['followers_count']
    self.url = info['urls']['Twitter']

    self.save!
  end

end
