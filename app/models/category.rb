class Category < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates_uniqueness_of :name, case_sensitive: false
  validates :name, presence: true

end
