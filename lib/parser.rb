require "csv"

class Parser
  def self.parse(csv_file_path, directory)
    csv = CSV.open(csv_file_path, headers: true, header_converters: [:downcase, :symbol])

    # Transform into intermediate data structure
    # Group by Chapter and then order
    # Chapter-3: [{highlight: text, url: url}....]

    book_notes = {}

    csv.reverse_each do |row|
      book_notes[:book_title] = row[:book_title]
      book_notes[:book_url] = row[:book_url]
      if book_notes[row[:chapter_title]].nil?
        book_notes[row[:chapter_title]] = [
          {
            highlight: row[:highlight],
            annotation_url: row[:annotation_url],
            personal_note: row[:personal_note],
            chapter_url: row[:chapter_url]
          }
        ]
      else
        book_notes[row[:chapter_title]] << {
          highlight: row[:highlight],
          annotation_url: row[:annotation_url],
          personal_note: row[:personal_note],
          chapter_url: row[:chapter_url]
        }
      end
    end

    book_title = book_notes.delete(:book_title)
    book_url = book_notes.delete(:book_url)
    file_name = book_title.downcase.gsub(/\s+/, " ").gsub(/\s/, "_").gsub(/\W/, "") + ".md"
    file = File.open("#{directory}/#{file_name}", "w")
    file.write("# [#{book_title} Notes](#{book_url})")

    book_notes.each do |chapter, annotations|
      # Chapter heading
      file.write("\n\n## [#{chapter}](#{annotations.first[:chapter_url]})")
      # Chapter annotations
      annotations.each do |annotation|
        file.write("\n[#{annotation[:highlight]}](#{annotation[:annotation_url]})")
        file.write("\n#{annotation[:personal_note]}")
      end
    end
    file.close
  end
end
