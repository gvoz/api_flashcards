class CheckTranslate
  attr_reader :translation_result

  def call(card, user_translation)
    if card.translated_text == user_translation
      { message: 'correct translation notice' }
    else
      { message: 'incorrect translation' }
    end
  end
end
