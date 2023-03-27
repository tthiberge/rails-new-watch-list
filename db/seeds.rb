require 'open-uri'
require 'json'
# require 'nokogiri'

puts "Cleaning the db"
List.destroy_all # Deletes related bookmarks
Bookmark.destroy_all # Should be useless because of just before
Movie.destroy_all



puts "Seeding"

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_hash = JSON.parse(URI.open(url).read)
movies_results = movies_hash["results"]

# p movies_results # Array de hash

movies_results.each do |movie|
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end


# LISTS
list_Adventure = List.create(name: "Adventure")
list_Foreign = List.create(name: "Foreign")
list_Action = List.create(name: "Action")
list_Sadness = List.create(name: "Sadness")
list_Epic = List.create(name: "Epic")


puts "Seeded"
puts "#{Movie.all.count} movies created"
puts "#{List.all.count} lists created"
