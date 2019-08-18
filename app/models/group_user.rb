class GroupUser < ApplicationRecord
  belongs_to :guroup
  belongs_to :user
end
