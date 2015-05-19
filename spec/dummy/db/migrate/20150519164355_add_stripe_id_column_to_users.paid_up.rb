# This migration comes from paid_up (originally 20150519164237)
class AddStripeIdColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string, index: true
  end
end
