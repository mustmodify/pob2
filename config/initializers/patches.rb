puts "Patching..."
Dir[Rails.root.join("app/patches/*.rb")].each {|f| require f}

