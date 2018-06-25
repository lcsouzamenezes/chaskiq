class CreateMetrics < ActiveRecord::Migration[5.2]
  def change
    create_table :metrics do |t|
      t.references :campaign, index: true
      t.references :trackable, polymorphic: true, index: true, null: false
      t.string :action
      t.string :host
      t.string :data
      t.timestamps
    end
  end
end