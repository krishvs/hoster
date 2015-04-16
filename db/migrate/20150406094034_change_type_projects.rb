class ChangeTypeProjects < ActiveRecord::Migration
  def change
  	rename_column :projects, :type, :status
  end
end
