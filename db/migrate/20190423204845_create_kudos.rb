class CreateKudos < ActiveRecord::Migration[5.2]
  def change
    create_table :kudos do |t|
      t.string :message
      t.bigint :given_by_id
      t.bigint :given_to_id

      t.timestamps
    end
    add_foreign_key :kudos, :users, column: :given_by_id, primary_key: "id"
    add_foreign_key :kudos, :users, column: :given_to_id, primary_key: "id"
  end
end
