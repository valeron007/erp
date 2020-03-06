class CreateSTransactionMaterials < ActiveRecord::Migration
  def change
    create_table :s_transaction_materials do |t|
      t.references :s_material, index: true, foreign_key: true
      t.references :s_transaction, index: true, foreign_key: true
      t.float :s_amount

      t.timestamps null: false
    end
  end
end
