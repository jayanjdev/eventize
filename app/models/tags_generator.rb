require 'engtagger'

class TagsGenerator
  def initialize(str)
    @str = str
  end

  def tagger
    @tgr ||= EngTagger.new
  end

  def tagged
    @tagged ||=tagger.add_tags(@str)
  end

  def nouns
    tagger.get_nouns(tagged).keys
  end

  def adjectives
    tagger.get_adjectives(tagged).keys
  end

  def tags
    (nouns + adjectives).uniq
  end
end
