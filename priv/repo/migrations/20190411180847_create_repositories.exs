defmodule AwesomeElixirParser.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :link, :string
      add :description, :text
      add :stars, :integer
      add :days_from_last_commit, :integer
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:repositories, [:name])
    create index(:repositories, [:category_id])
  end
end
