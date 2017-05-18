class AddArquivoToStudio < ActiveRecord::Migration
  def change
    add_column :studios, :arquivo_id, :integer
  end
end
