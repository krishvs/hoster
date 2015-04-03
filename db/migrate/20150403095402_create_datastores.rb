class CreateDatastores < ActiveRecord::Migration
  def change
    create_table :datastores do |t|
      t.string :type
      t.string :version
      t.string :url
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
