class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member
  # gem imagemagick / paperclip

  scope :last_six, -> { limit(6).order(created_at: :desc) }

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents
end
