def sum_of_cards(cards)
  arr = cards.map{|x| x[0]}

  total = 0
  arr.each do |x|
    if x == 'Ace'
      total += 11
    elsif x.to_i == 0 
      total += 10
    else
      total += x.to_i
    end
  end

  if total > 21
    arr.count('Ace').times do 
      total -= 10
    end
  end
  total 
end 

def player_win_bust(total_cards)
  if total_cards == 21
    return "You win!"
  elsif total_cards > 21
    return "You have bust."
  end
  nil
end

def bust_or_compare_hands(player_total, dealer_total)
  if dealer_total >= 17 && 21 >= dealer_total && player_total > dealer_total
    return "You win! Your hand is: #{player_total}. Dealers hand is: #{dealer_total}."
  elsif dealer_total >= 17 && 21 >= dealer_total && player_total < dealer_total
    return "Dealer wins! Your hand is: #{player_total}. Dealers hand is: #{dealer_total}."
  elsif dealer_total > 21 
    return "Dealer bust. You win!"
  end 
  nil 
end

  

loop do 
  suits = [' of Hearts', ' of Spades', ' of Diamonds', ' of Clubs']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
  deck = cards.product(suits) 
  deck.shuffle! 
  players_cards = []
  dealers_cards = []

  puts "-------------- Welcome to Blackjack! --------------"
  puts "My name is Ruby and I am your dealer. What is your name?"
  players_name = gets.chomp 
  puts "Welcome #{players_name}!"

  
  players_cards << deck.pop
  puts "This is your first card: #{players_cards.flatten}"

  dealers_cards << deck.pop 
  puts "This is the dealer's first card: #{dealers_cards.flatten}"

# Loop player's hand
  begin
    puts "Would you like to hit or stay (h/s)?"
    player_move = gets.chomp.downcase 
    players_cards << deck.pop
    if player_move == 's' 
      break
    end
    puts "These are your cards: #{players_cards.flatten}"
    player_total = sum_of_cards(players_cards)
    puts "This is your total: #{player_total}"
  end until player_move == 's' || player_win_bust(player_total) 

  if player_win_bust(player_total)
    puts player_win_bust(player_total) 
  end 

# If player has not won/busted, loop dealer's hand
  if player_move == 's'
    puts "You chose to stay."
    begin
      puts "Dealer takes card"
      dealers_cards << deck.pop 
      sleep 0.5
      puts "These are the dealer's cards: #{dealers_cards.flatten}"
      dealer_total = sum_of_cards(dealers_cards) 
      puts "This is dealer's total: #{dealer_total}"
      sleep 0.5
    end until bust_or_compare_hands(player_total, dealer_total)

    if bust_or_compare_hands(player_total, dealer_total)
      sleep 0.5
      puts bust_or_compare_hands(player_total, dealer_total)
    end
  end

  sleep 0.5
  puts "Play again? (y/n)"
  play_again = gets.chomp.downcase
  break if play_again == 'n'
end 


