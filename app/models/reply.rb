class Reply < ApplicationRecord
  belongs_to :contact
  belongs_to :user # 返信したユーザー（管理者）
end