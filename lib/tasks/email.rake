namespace :email do # se esta haciendo una prueba para enviar todos los productos al primer usuario
  desc "Sends the most voted products created yesterday"
  task daily_products: :environment do
    UserMailer.daily_products(User.first, Product.all).deliver_now
  end
end