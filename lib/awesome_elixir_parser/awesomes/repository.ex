defmodule AwesomeElixirParser.Awesomes.Repository do
  use Ecto.Schema
  import Ecto.Changeset
  alias AwesomeElixirParser.Awesomes.Category

  schema "repositories" do
    field :days_from_last_commit, :integer
    field :description, :string
    field :link, :string
    field :name, :string
    field :stars, :integer
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(repository, attrs) do
    repository
    |> cast(attrs, [:name, :link, :description, :stars, :days_from_last_commit])
    |> validate_required([:name, :link, :description])
    |> unique_constraint(:name)
    |> assoc_constraint(:category)
  end
end
