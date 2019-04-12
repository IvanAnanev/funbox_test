defmodule AwesomeElixirParser.Awesomes do
  @moduledoc """
  The Awesomes context.
  """

  import Ecto.Query, warn: false
  alias AwesomeElixirParser.Repo

  alias AwesomeElixirParser.Awesomes.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update(force: true)
  end

  @doc """
  Create or updates a category.

  ## Examples

      iex> create_or_update_category(%{field: new_value})
      {:ok, %Category{}}

      iex> create_or_update_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_or_update_category(%{name: name} = attrs) do
    case Repo.get_by(Category, name: name) do
      nil -> create_category(attrs)
      category -> update_category(category, attrs)
    end
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  @doc """
  Delete not actual categories

  ## Examples

      iex> delete_not_actual_categories(timestamp)
  """
  def delete_not_actual_categories(timestamp) do
    query =
      from c in Category,
        where: c.updated_at < ^timestamp

    Repo.delete_all(query)
  end

  alias AwesomeElixirParser.Awesomes.Repository

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update(force: true)
  end

  @doc """
  Deletes a Repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{source: %Repository{}}

  """
  def change_repository(%Repository{} = repository) do
    Repository.changeset(repository, %{})
  end

  @doc """
  Create or updates a repository.

  ## Examples

      iex> create_or_update_repository(%{field: new_value})
      {:ok, %Category{}}

      iex> create_or_update_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_repository(%{name: name} = attrs) do
    case Repo.get_by(Repository, name: name) do
      nil -> create_repository(attrs)
      repository -> update_repository(repository, attrs)
    end
  end

  @doc """
  Delete not actual repositories

  ## Examples

      iex> delete_not_actual_repositories(timestamp)
  """
  def delete_not_actual_repositories(timestamp) do
    query =
      from r in Repository,
        where: r.updated_at < ^timestamp

    Repo.delete_all(query)
  end
end
