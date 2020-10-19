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

        it 'Raises an error if balance exeeds max (90)' do
            expect{subject.top_up(91)}.to raise_error("This top up exeeds max balance of £90.")
        end
    end

    describe 'pay_fare' do
        it "Deducts the train fare from the user's balance" do
            subject.top_up(1)
            expect(subject.pay_fare(1)).to eq "You have paid £1."
            expect(subject.balance).to eq 0
        end
    end

    describe 'in_journey?' do
        let(:station) {double("KX")}
        it 'Returns true if in transit' do
            subject.top_up(2)
            subject.touch_in(station)
            expect(subject.in_journey?).to eq true
        end

        it 'Returns false if not in transit' do
            expect(subject.in_journey?).to eq false
        end
    end

    describe 'touch_in' do
        let(:station) {double("KX")}
        it 'Sets the starting station attr and returns it' do
            subject.top_up(2)
            expect(subject.touch_in(station)).to eq "You have touched in at #{station}."
        end

        it 'Raises an error if user has not got minimum balance.' do
            expect{subject.touch_in(station)}.to raise_error "You cannot cover minimum fare."
        end
    end

    describe 'touch_out' do
        let(:station) {double("Blackfriars")}
        it 'Sets the finishing station' do
            expect(subject.touch_out(station)).to eq "You have touched out at #{station}."
        end

        it 'Deducts min fare from balance' do
            subject.top_up(2)
            expect{subject.touch_out(station)}.to change{subject.balance}.by(-1)
        end
    end

end