# frozen_string_literal: true

module AbsorbApi
  class Lesson < Base
    attr_accessor :id, :chapter_id, :name, :description, :notes, :type, :width, :height, :url, :use_popup, :passing_score, :weight, :ref_id
  end
end
