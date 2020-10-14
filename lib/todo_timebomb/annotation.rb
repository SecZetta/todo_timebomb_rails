module TodoTimebomb
  class Annotation
    attr_reader :file, :line, :tag, :text, :expiration_date

    def initialize(file, orig_annotation)
      @file = file
      @line = orig_annotation.line
      @tag = orig_annotation.tag
      @expiration_date, @text = split_orig_text(orig_annotation.text)
    end

    def has_expiration?
      @expires ||= !expiration_date.nil?
    end

    def expired?
      has_expiration? && expiration_date < Date.today
    end

    def expires_within?(duration)
      has_expiration? && !expired? && expiration_date < Date.today + duration
    end

    private

    def split_orig_text(orig_text)
      match_data = orig_text.match /(\[\d+-\d+-\d+\])\W*(.*)/
      if match_data.present?
        [Date.parse(match_data[1]), match_data[2]]
      else
        [nil, orig_text]
      end
    end

    def to_s
      ["#{file}:#{line}", expiration_date, tag, text].compact.join(' - ')
    end
  end
end
