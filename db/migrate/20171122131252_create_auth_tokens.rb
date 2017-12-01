class CreateAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.string :refresh_token
      t.datetime :token_expires_at
      t.datetime :refresh_token_expires_at
      t.references :tokenable, polymorphic: true

      t.timestamps
    end
  end
end
