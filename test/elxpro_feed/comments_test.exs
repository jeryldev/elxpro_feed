defmodule ElxproFeed.CommentsTest do
  use ElxproFeed.DataCase

  alias ElxproFeed.Comments

  describe "comments" do
    alias ElxproFeed.Comments.Comment

    import ElxproFeed.CommentsFixtures

    @invalid_attrs %{content: nil, likes: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      comments = Comments.list_comments()

      assert Enum.member?(comments, comment)
      assert Comments.list_comments() |> Enum.count() > 0
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Comments.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{content: "some content", likes: 42}

      assert {:ok, %Comment{} = comment} = Comments.create_comment(valid_attrs)
      assert comment.content == "some content"
      assert comment.likes == 42
    end

    test "create_comment/1 with invalid data do not create a comment" do
      invalid_attrs = %{content: "some content", likes: "wrong input"}

      assert {:error, %Ecto.Changeset{} = reason} = Comments.create_comment(invalid_attrs)
      assert reason.errors == [likes: {"is invalid", [type: :integer, validation: :cast]}]
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Comments.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{content: "some updated content", likes: 43}

      assert {:ok, %Comment{} = comment} = Comments.update_comment(comment, update_attrs)
      assert comment.content == "some updated content"
      assert comment.likes == 43
    end

    test "update_comment/2 with invalid data do not update the comment" do
      comment = comment_fixture()
      invalid_update_attrs = %{content: "some updated content", likes: "wrong input"}

      assert {:error, %Ecto.Changeset{} = reason} =
               Comments.update_comment(comment, invalid_update_attrs)

      assert reason.errors == [likes: {"is invalid", [type: :integer, validation: :cast]}]
      assert comment.content == "some content"
      assert comment.likes == 42
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Comments.update_comment(comment, @invalid_attrs)
      assert comment == Comments.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Comments.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Comments.change_comment(comment)
    end
  end
end
