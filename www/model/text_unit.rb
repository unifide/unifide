class TextUnit < ActiveRecord::Base

    belongs_to :text_unit_type
    belongs_to :unit

end
