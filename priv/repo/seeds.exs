alias ElxproFeed.Comments
alias ElxproFeed.Feeds.Feed
alias ElxproFeed.Repo

content = "hi
==

  Lorem ipsum dolor sit, amet consectetur adipisicing elit. Eius facilis doloremque fugit.!!!

  Lorem ipsum dolor sit, amet consectetur adipisicing elit. Eius facilis doloremque fugit.!!!

  Lorem ipsum dolor sit, amet consectetur adipisicing elit. Eius facilis doloremque fugit.!!!

  [elxpro/gustavo](https://www.linkedin.com/in/gustavo-oliveira-642b23aa/)"

feed_1 = %{
  content: content,
  author: "Jeryl Estopace",
  avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
  role: "Software Engineer"
}

feed_2 = %{
  content: content,
  author: "Gustavo Oliviera",
  avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
  role: "Elixir Developer"
}

feed_3 = %{
  content: content,
  author: "Joe Morris",
  avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
  role: "Principal Engineer"
}

feeds = [feed_1, feed_2, feed_3]

Enum.each(feeds, fn feed ->
  {:ok, feed} =
    %Feed{}
    |> Feed.changeset(feed)
    |> Repo.insert()

  Comments.create_comment(%{content: "Hi!!!", feed_id: feed.id})
end)
