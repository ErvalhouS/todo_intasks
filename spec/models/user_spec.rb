require 'rails_helper'

RSpec.describe User, type: :model do
  it { have_many :tasks }
  it { have_many :categories }
  it { accept_nested_attributes_for :categories }
  it { accept_nested_attributes_for :tasks }

  describe '#admin?' do
    it 'returns false if user.role is default' do
      expect(FactoryBot.build(:user).admin?).to eq(false)
    end
    it 'returns false if user.role is not admin' do
      expect(FactoryBot.build(:user, role: 'anyotherrole').admin?).to eq(false)
    end
    it 'returns true if user.role is admin' do
      expect(FactoryBot.build(:admin).admin?).to eq(true)
    end
  end
end
