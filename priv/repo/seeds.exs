alias ElxproFeed.Comments
alias ElxproFeed.Feeds.Feed
alias ElxproFeed.Repo

feed_1 = %{
  content: "
    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Facilis aliquid culpa soluta.

    Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos excepturi maiores culpa?

    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum voluptatibus voluptas ipsam.

    Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptate illo dicta odio.

    [elxpro/jeryl](https://www.linkedin.com/in/jeryldev/)
  ",
  author: "Jeryl Estopace",
  avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
  role: "Software Engineer"
}

feed_2 = %{
  content: "
    Lorem ipsum dolor sit amet consectetur, adipisicing elit. Cum laboriosam laborum quam?

    Lorem ipsum dolor sit amet consectetur adipisicing elit. Tempore vel animi tenetur.

    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Deleniti maxime explicabo exercitationem.

    Lorem ipsum, dolor sit amet consectetur adipisicing elit. Accusantium quia libero velit.

    [elxpro/gustavo](https://www.linkedin.com/in/gustavo-oliveira-642b23aa/)
  ",
  author: "Gustavo Oliviera",
  avatar_url: "https://avatars.githubusercontent.com/u/26645913?v=4",
  role: "Elixir Developer"
}

feed_3 = %{
  content: "
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ullam eligendi non temporibus!

    Lorem, ipsum dolor sit amet consectetur adipisicing elit. Mollitia, officiis! Ad, harum!

    Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque, perspiciatis nisi. Rem!

    Lorem ipsum dolor sit amet consectetur adipisicing elit. Molestiae est odit labore!

    [elxpro/joe](https://www.linkedin.com/in/joedmorris/)
  ",
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
