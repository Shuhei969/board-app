# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  card_content :text             not null
#  card_title   :string           not null
#  deadline     :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  board_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#
class Task < ApplicationRecord
    validates :card_title, presence: true
    validates :card_content, presence: true
    has_many :comments
    belongs_to :user
    belongs_to :board
    has_one_attached :eyecatch
end
