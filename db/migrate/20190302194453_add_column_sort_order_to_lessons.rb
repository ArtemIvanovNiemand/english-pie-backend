class AddColumnSortOrderToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :sort_order, :integer
  end
end
