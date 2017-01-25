module ApiFlashcards
  class CardSerializer < ActiveModel::Serializer
    attributes :id, :original_text, :translated_text, :review_date,
               :created_at, :updated_at
  end
end
