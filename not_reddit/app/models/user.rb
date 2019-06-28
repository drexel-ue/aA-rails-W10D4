# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :username, :session_token, :password_digest, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    
    attr_reader :password

    after_initialize :ensure_session_token

    include Ownerable

    has_many :subs,
        foreign_key: :moderator_id

    def self.find_by_credentials(username, pass)
        user = User.find_by(username: username)

        if user && user.is_password?(pass)
            return user
        else
            return nil
        end
    end

    def password=(pass)
        @password = pass
        self.password_digest = BCrypt::Password.create(pass)
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64(16)
        self.save!
        self.session_token
    end

    def is_password?(pass)
        BCrypt::Password.new(self.password_digest).is_password?(pass)
    end
end
