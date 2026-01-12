class CreateDenominations < ActiveRecord::Migration[8.1]
  def change
    create_table :denominations, id: :uuid do |t|
      t.integer :value
      t.integer :available_count

      t.timestamps
    end
  end
end
