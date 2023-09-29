class LoanSerializer < ActiveModel::Serializer
  attributes :id, :amount, :interest_rate, :interest_amount, :start_date
  has_one :client
end
