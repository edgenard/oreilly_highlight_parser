require "spec_helper"
require "debug"
require_relative "../lib/parser"

describe Parser do
  describe ".parse" do
    let(:test_csv) { File.open("#{__dir__}/fixtures/test_highlights.csv") }
    let(:expected_output) { File.open("#{__dir__}/fixtures/test_output.md") }
    let(:expected_output_path) { "#{__dir__}/tmp/my_super_long_title_with_commas.md" }

    after do
      File.delete(expected_output_path)
    end

    it "writes a file whose name is the book title" do
      Parser.parse(test_csv.path, __dir__ + "/tmp")
      expect(File.exist?(expected_output_path)).to eq(true)
    end

    it "file matches the expected output" do
      Parser.parse(test_csv.path, __dir__ + "/tmp")
      outputted_file = File.open(expected_output_path)
      expect(FileUtils.compare_file(outputted_file, expected_output)).to eq(true)
    end
  end
end
