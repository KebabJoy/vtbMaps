json.(point, :raw_value)
json.coords do
  json.(point.coords, :lat, :lon)
end
