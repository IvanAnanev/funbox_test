defmodule AwesomeElixirParser.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :text

      timestamps()
    end

    create index("categories", [:name], unique: true)
  end
end
