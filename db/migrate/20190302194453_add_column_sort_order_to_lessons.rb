class AddColumnSortOrderToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :sort_order, :integer
  end
end
