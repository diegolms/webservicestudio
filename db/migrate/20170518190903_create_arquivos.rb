class CreateArquivos < ActiveRecord::Migration
  def change
    create_table :arquivos do |t|
      t.string   :arquivo_file_name
      t.string   :arquivo_content_type
      t.integer  :arquivo_file_size, :precision => 38
      t.string   :nome_original
      t.timestamps null: false
    end
  end
end
