require 'net/http'
require 'json'

url = URI("https://f-games-api.herokuapp.com/api/v1/games")

continue = true

options = ['Consultar jogos']

options.unshift 'Sair'

def list_games(url)
  puts 'Listando games'
  resp = Net::HTTP.get(url)

  json_resp = JSON.parse(resp, symbolize_names: true)
  data = json_resp[:data]
  games = data[:games]

  # games = JSON.parse(resp, symbolize_names: true)[:data][:games]

  games.each.with_index do |game, index|
    puts "#{index +1} - #{game[:name]}, genero: #{game[:genre]}"
  end

  sleep 4
end

while continue
  system('clear')
  puts 'Escolha o numero de uma opcao:'

  options.each.with_index do |option, index|
    puts "#{index} - #{option}"
  end

  option = gets.chomp.to_i

  list_games(url) if option == options.index('Consultar jogos')

  continue = false if option.zero?
end
