class Category < ActiveRecord::Base
    # Gem Friendly_Id urls amigaveis
    include FriendlyId
    friendly_id :description, use: :slugged

    # associations
    has_many :ads

    # validations
    validates_presence_of :description

    scope :order_by_description, -> { order(:description) }

end
