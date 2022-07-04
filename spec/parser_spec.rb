require "spec_helper"
require "debug"
require_relative "../lib/parser"

describe Parser do
  describe ".parse" do
    let(:test_csv) { File.new("./spec/fixtures/test_highlights.csv") }
    let(:test_output) { File.new("./spec/fixtures/test_output.md") }
    let(:expected_output_path) { "#{__dir__}/tmp/my_super_long_title_with_commas.md" }

    after do
      File.delete(expected_output_path)
    end

    it "writes a file whose name is the book title" do
      Parser.parse(test_csv.path, __dir__ + "/tmp")
      expect(File.exist?(expected_output_path)).to eq(true)
    end

    it "file matches the expected output"
  end
end
