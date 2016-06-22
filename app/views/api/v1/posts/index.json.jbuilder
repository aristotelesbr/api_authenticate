json.array!(@api_v1_posts) do |api_v1_post|
  json.extract! api_v1_post, :id
  json.url api_v1_post_url(api_v1_post, format: :json)
end
