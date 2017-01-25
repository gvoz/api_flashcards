class Card < ApplicationRecord
  belongs_to :user
  before_create :set_review_date_as_now

  validates_presence_of :original_text, :translated_text

  private

  def set_review_date_as_now
    self.review_date = Time.now
  end
end
