require 'addressable/uri'
require 'rest-client'

def user_index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users',
    query_values: {
      test_value: 'something'
    }
  ).to_s

  p url

  puts RestClient.get(url, params: {'a' => 'b'})
end


def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s
  # begin
    puts RestClient.post(
        url,
        { user: {name: "Gizmo", email: "gizmo@gizmo.gizmo"} }
    )
  # rescue
  #   raise MissingParamsError.new "Missing Params!"
  # end
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/4'
  ).to_s
  # begin
    puts RestClient.put(
        url,
        { user: {name: "Gizmo", email: "gizmogiz@gizmo.gizmo"} }
    )
  # rescue
  #   raise MissingParamsError.new "Missing Params!"
  # end
end


class MissingParamsError < RestClient::Exception
end

update_user
