defmodule TodaySocial.JournalTest do
  use TodaySocial.DataCase

  alias TodaySocial.Journal

  describe "posts" do
    alias TodaySocial.Journal.Post

    @valid_attrs %{yesterday: "some yesterday", today: "some yesterday", user_id: 1}
    @update_attrs %{yesterday: "some updated yesterday", today: "some updated today", user_id: 2}
    @invalid_attrs %{yesterday: nil, today: nil, user_id: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journal.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Journal.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Journal.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Journal.create_post(@valid_attrs)
      assert post.yesterday == "some yesterday"
      assert post.today == "some today"
      assert post.user_id == 1
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Journal.update_post(post, @update_attrs)
      assert post.yesterday == "some updated yesterday"
      assert post.today == "some updated today"
      assert post.user_id == 2
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_post(post, @invalid_attrs)
      assert post == Journal.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Journal.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Journal.change_post(post)
    end
  end

  describe "posts" do
    alias TodaySocial.Journal.Post

    @valid_attrs %{yesterday: "some yesterday", today: "some yesterday", user_id: 42}
    @update_attrs %{yesterday: "some updated yesterday", today: "some updated today", user_id: 43}
    @invalid_attrs %{body: nil, user_id: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journal.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Journal.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Journal.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Journal.create_post(@valid_attrs)
      assert post.body == "some body"
      assert post.user_id == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Journal.update_post(post, @update_attrs)
      assert post.body == "some updated body"
      assert post.user_id == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_post(post, @invalid_attrs)
      assert post == Journal.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Journal.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Journal.change_post(post)
    end
  end

  describe "posts" do
    alias TodaySocial.Journal.Post

    @valid_attrs %{today: "some today", user_id: 42, yesterday: "some yesterday"}
    @update_attrs %{today: "some updated today", user_id: 43, yesterday: "some updated yesterday"}
    @invalid_attrs %{today: nil, user_id: nil, yesterday: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journal.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Journal.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Journal.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Journal.create_post(@valid_attrs)
      assert post.today == "some today"
      assert post.user_id == 42
      assert post.yesterday == "some yesterday"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journal.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Journal.update_post(post, @update_attrs)
      assert post.today == "some updated today"
      assert post.user_id == 43
      assert post.yesterday == "some updated yesterday"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Journal.update_post(post, @invalid_attrs)
      assert post == Journal.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Journal.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Journal.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Journal.change_post(post)
    end
  end
end
