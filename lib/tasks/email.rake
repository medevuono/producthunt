
namespace :email do
  desc "Sends the most voted products created yesterday"
  task daily_products: :environment do
    products = Product.
      select('products.name, products.description, count(votes.id) AS votes_counts').
      joins(:votes).
      where(created_at: 1.day.ago).
      group('products.name, products.description').
      order('votes_counts DESC').
      limit(5)


    if products.count > 0
      User.all.each do |user|
        UserMailer.daily_products(user, products).deliver_now
      end
    end
  end
end

#namespace :email do # se esta haciendo una prueba para enviar todos los productos al primer usuario
#  desc "Sends the most voted products created yesterday"
#  task daily_products: :environment do
#    UserMailer.daily_products(User.first, Product.all).deliver_now
#  end
#end