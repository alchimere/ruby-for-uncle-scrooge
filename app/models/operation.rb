class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :operation_category
end
