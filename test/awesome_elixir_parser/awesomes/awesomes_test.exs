defmodule AwesomeElixirParser.AwesomesTest do
  use AwesomeElixirParser.DataCase

  alias AwesomeElixirParser.Awesomes

  describe "categories" do
    alias AwesomeElixirParser.Awesomes.Category

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Awesomes.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Awesomes.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Awesomes.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Awesomes.create_category(@valid_attrs)
      assert category.description == "some description"
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Awesomes.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Awesomes.update_category(category, @update_attrs)
      assert category.description == "some updated description"
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Awesomes.update_category(category, @invalid_attrs)
      assert category == Awesomes.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Awesomes.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Awesomes.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Awesomes.change_category(category)
    end
  end

  describe "repositories" do
    alias AwesomeElixirParser.Awesomes.Repository

    @valid_attrs %{
      days_from_last_commit: 42,
      description: "some description",
      link: "some link",
      name: "some name",
      stars: 42
    }
    @update_attrs %{
      days_from_last_commit: 43,
      description: "some updated description",
      link: "some updated link",
      name: "some updated name",
      stars: 43
    }
    @invalid_attrs %{
      days_from_last_commit: nil,
      description: nil,
      link: nil,
      name: nil,
      stars: nil
    }

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Awesomes.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Awesomes.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Awesomes.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Awesomes.create_repository(@valid_attrs)
      assert repository.days_from_last_commit == 42
      assert repository.description == "some description"
      assert repository.link == "some link"
      assert repository.name == "some name"
      assert repository.stars == 42
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Awesomes.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()

      assert {:ok, %Repository{} = repository} =
               Awesomes.update_repository(repository, @update_attrs)

      assert repository.days_from_last_commit == 43
      assert repository.description == "some updated description"
      assert repository.link == "some updated link"
      assert repository.name == "some updated name"
      assert repository.stars == 43
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Awesomes.update_repository(repository, @invalid_attrs)
      assert repository == Awesomes.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Awesomes.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Awesomes.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Awesomes.change_repository(repository)
    end
  end
end
