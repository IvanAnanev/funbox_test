defmodule AwesomeElixirParser.Awesomes.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias AwesomeElixirParser.Awesomes.Repository

  schema "categories" do
    field :description, :string
    field :name, :string
    has_many :repositories, Repository

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
