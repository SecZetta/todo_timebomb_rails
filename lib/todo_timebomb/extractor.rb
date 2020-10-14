module TodoTimebomb
  class Extractor
    def initialize(keywords, directories)
      @keywords = keywords
      @directories = directories
    end

    def expired
      @expired ||= all.select(&:expired?)
    end

    def unexpired
      @unexpired ||= all.reject(&:expired?)
    end

    def expiring_within(duration)
      all.select { |a| a.expires_within? duration }
    end

    def with_expiration
      @with_expiration ||= all.select(&:has_expiration)
    end


    def without_expiration
      @without_expiration ||= all.reject(&:has_expiration?)
    end

    def all
      @all ||= begin
        SourceAnnotationExtractor.new(keywords.join('|')).find(directories).flat_map do |k, v|
          v.map do |orig_annotation|
            Annotation.new(k, orig_annotation)
          end
        end
      end
    end

    private

    attr_reader :keywords, :directories
  end
end
