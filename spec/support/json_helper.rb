module JsonHelper
  def json
    JSON.parse(last_response.body, symbolize_names: true)
  end
end
