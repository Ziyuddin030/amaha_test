require "rails_helper"

RSpec.describe CustomerFilterService do
  describe "#call" do
    def tempfile_with_lines(lines)
      file = Tempfile.new("customers.json")
      lines.each { |l| file.write(l + "\n") }
      file.rewind
      file
    end

    after do
      @tempfiles&.each { |f| f.close! rescue f.close }
    end

    it "skips invalid JSON lines and filters within 100km of Mumbai" do
      lines = [
        '{"user_id": 2, "name": "Near", "latitude": "19.1", "longitude": "72.8"}',
        "invalid-json",
        '{"user_id": 1, "name": "Far", "latitude": "10.0", "longitude": "70.0"}',
        '{"user_id": 3, "name": "AlsoNear", "latitude": "19.05", "longitude": "72.76"}'
      ]

      file = tempfile_with_lines(lines)
      @tempfiles ||= []
      @tempfiles << file

      result = described_class.new(file).call

      expect(result).to eq([
        { user_id: 2, name: "Near" },
        { user_id: 3, name: "AlsoNear" }
      ].sort_by { |c| c[:user_id] })
    end
  end
end
