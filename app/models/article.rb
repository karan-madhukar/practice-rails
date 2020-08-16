class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :title, :description, presence: true
  belongs_to :user
  belongs_to :category
  has_many :reactions, dependent: :destroy

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
    end
  end

end
