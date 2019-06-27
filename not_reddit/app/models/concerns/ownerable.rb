module Ownerable

    extend ActiveSupport::Concern

    included do
        has_many :posts, as: :ownerable
    end


end