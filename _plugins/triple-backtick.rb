require 'redcarpet'

class FencedCodeBlockWithRainbow < Redcarpet::Render::HTML
  def block_code(code, language)
    data_language = language ? " data-language=\"#{language}\"" : ''

    "<pre><code#{data_language}>#{code}</code></pre>"
  end
end

module Jekyll
  class MarkdownConverter
    def convert(content)
      markdown = Redcarpet::Markdown.new FencedCodeBlockWithRainbow,
        :tables => true,
        :autolink => true,
        :fenced_code_blocks => true

      markdown.render content
    end
  end
end
