class AddUserLinksToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :created_by, foreign_key: { to_table: :users } # Makes sense for created_by to be required because we need a source but... 
    add_reference :tasks, :assigned_to, foreign_key: { to_table: :users } # ^ ...assignment can be done later so no need for required.
    # HOWEVER, for the sake of dev (i dont wanna edit seeds xD) - lets leave them both nullable
  end
end
