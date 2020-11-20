require_relative '../../lib/wixanswers'

RSpec.describe WixAnswers::Enumerations, type: :module do
  describe 'title' do
    it 'should retrieve title given status type' do
      expect(WixAnswers::Enumerations::TicketStatus.title(100)).to eq("Open")
    end

    it 'should retrieve empty string given unknown type' do
      expect(WixAnswers::Enumerations::TicketStatus.title(200)).to eq("")
    end
  end
end