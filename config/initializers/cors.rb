Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:5173",  "127.0.0.1:5173", "https://mood-trackers.girlknowscode.com"

    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      credentials: true
  end
end
