class AddDefaultValueToShowAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :accessories, :image, :string, default: 'http://fixmfg.com/wp-content/uploads/2017/02/WheelieWrench_angleLR.jpg'
  end
end
