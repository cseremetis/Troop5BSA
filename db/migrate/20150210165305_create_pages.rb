class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
        t.string :title
        t.string :form_id
        t.string :notification
        t.string :pic
    end
  end

  def down
    drop_table :pages
  end
end
