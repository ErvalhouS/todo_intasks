require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to :user }
  it { should belong_to(:category).optional }
  it { should validate_length_of(:title).is_at_least 5 }

  describe '#expired?' do
    it 'returns false for default record' do
      expect(FactoryBot.build(:task).expired?).to eq(false)
    end
    it 'returns true for records with due_at in the past' do
      expect(FactoryBot.build(:task, due_at: Date.current-rand(10).days).expired?).to eq(true)
    end
  end

  describe '#completed' do
    it 'returns false for default records' do
      expect(FactoryBot.build(:task).completed).to eq(false)
    end
    it 'returns true for records with completed_at in the future' do
      expect(FactoryBot.build(:task, completed_at: Date.current+2.days).completed).to eq(true)
    end
    it 'returns true for records with completed_at in the past' do
      expect(FactoryBot.build(:task, completed_at: Date.current-2.days).completed).to eq(true)
    end
  end

  describe '#completed=(complete)' do
    task = FactoryBot.build(:task)
    it 'assings nil to completed at if complete is not "true"' do
      task.completed = nil
      expect(task.completed_at).to eq(nil)
      task.completed = false
      expect(task.completed_at).to eq(nil)
      task.completed = true
      expect(task.completed_at).to eq(nil)
    end
    it 'assings Date.current to completed at if complete is "true"' do
      task.completed = 'true'
      expect(task.completed_at.to_i).to eq(Time.current.to_i)
    end
  end

  describe '#non_expired_creation' do
    it 'validates if task is not expired?' do
      task = FactoryBot.build(:task)
      task.send('non_expired_creation')
      expect(task.valid?).to eq(true)
      task = FactoryBot.build(:task, due_at: Time.now+2.days)
      task.send('non_expired_creation')
      expect(task.valid?).to eq(true)
      task = FactoryBot.build(:task, due_at: Time.now-10.days)
      task.send('non_expired_creation')
      expect(task.valid?).to eq(false)
    end
  end
end
