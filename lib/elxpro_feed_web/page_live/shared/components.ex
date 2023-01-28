defmodule ElxproFeedWeb.PageLive.Shared.Components do
  use Phoenix.Component

  attr :avatar_url, :string, default: "https://avatars.githubusercontent.com/u/26645913?v=4"
  attr :avatar_alt, :string, default: "profile-image"

  attr :avatar_class, :string, default: "w-16 h-16 rounded-lg outline-2 outline-blue-200"

  attr :data_role, :string, required: true
  attr :data_id, :string, default: "profile-image-id"
  attr :has_border, :boolean, default: true

  def avatar(assigns) do
    ~H"""
    <img
      data-role={@data_role}
      data-id={@data_id}
      src={@avatar_url}
      alt={@avatar_alt}
      class={[@has_border && "border-2 border-blue-700", @avatar_class]}
    />
    """
  end
end
