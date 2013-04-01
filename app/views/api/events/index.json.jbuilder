json.root do
  json.events @events do |event|
    json.id event.id
    json.title event.full_title
  end
end