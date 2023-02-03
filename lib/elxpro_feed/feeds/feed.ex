defmodule ElxproFeed.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElxproFeed.Comments.Comment

  @fields ~w(content author role avatar_url)a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "feeds" do
    field :content, :string
    field :author, :string
    field :role, :string
    field :avatar_url, :string
    has_many :comments, Comment

    timestamps()
  end

  def changeset(feed, attrs) do
    feed
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
