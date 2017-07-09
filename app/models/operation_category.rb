class OperationCategory < ApplicationRecord
  belongs_to :operation_category, optional: true
  has_many :operation_categories
  has_many :operations
end
