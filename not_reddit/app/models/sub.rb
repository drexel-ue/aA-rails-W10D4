require_relative 'concerns/ownerable'

# == Schema Information
#
# Table name: subs
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#

class Sub < ApplicationRecord
    validates :title, :description, :moderator_id, presence: true

    has_many :posts

    include Ownerable
end
