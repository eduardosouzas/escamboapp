class Ad < ActiveRecord::Base

  # Constants
  QT_FOR_PAGE = 6
  # gem RatyRate - avaliacao com estrelas
  ratyrate_rateable 'quality'
  #callbackas
  before_save :md_to_html

  # associations
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  # validates
  validates :title, :description_short,:description_md , :category, :picture, :finish_date, presence: true
  validates :price, numericality: {greater_than: 0 }

  # gem imagemagick / paperclip
  scope :descending_order, ->(page){
        order(created_at: :desc).page(page).per(QT_FOR_PAGE) }
  scope :search, ->(term, page = 1){
        where("title LIKE ? ","%#{term}%" ).page(page).per(QT_FOR_PAGE)}

  scope :to_the, ->(member,page){where(member: member).page(page).per(QT_FOR_PAGE)}

  scope :random,-> (qtt = 3) {limit(qtt).order("RANDOM()")}


  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>", large: "800x300#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents

  private

    def md_to_html
          options = {
                  filter_html: true,
                  link_attributes: {
                      rel: "nofollow",
                      target: "_blank"
                      }
                   }

          extensions = {
          space_after_headers: true,
          autolink: true
          }

          renderer = Redcarpet::Render::HTML.new(options)
          markdown = Redcarpet::Markdown.new(renderer, extensions)

          self.description = markdown.render(self.description_md)

      end

end
