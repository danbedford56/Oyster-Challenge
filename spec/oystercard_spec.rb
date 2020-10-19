require 'card'

RSpec.describe Oyster_Card do
    
    describe 'Balance' do
        it 'Returns the balance' do
            expect(subject.balance).to eq 0
        end
    end

    describe 'top-up' do
        it 'Allows the user to add money and returns new balance' do
            expect(subject.top_up(1)).to eq "Your balance is now £#{subject.balance}."
        end
    end

end