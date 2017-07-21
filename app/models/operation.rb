class Operation < ApplicationRecord
  belongs_to :account
  belongs_to :operation_category

  def compute_category!
    # TODO
  end
end
