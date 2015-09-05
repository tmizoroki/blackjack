# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'stand', =>
      # window.a = @get 'dealerHand';
      (@get 'dealerHand').at(0).flip()
      (@get 'dealerHand').trigger("reveal")

    (@get 'dealerHand').on 'dealerDone', =>
      console.log "DEALER_DONE"
      @whoWon()
    (@get 'playerHand').on 'bust', =>
      console.log "BUSTED"
      @whoWon()

  whoWon:  ->
    playerScore = (@get 'playerHand').score
    dealerScore = (@get 'dealerHand').score

    if playerScore > 21
      alert "You busted!"
    else if playerScore > dealerScore
      alert "You Win!"
    else if dealerScore > 21
      alert "Dealer busted!"
    else if dealerScore > playerScore
      alert "Dealer Wins!"
    else if dealerScore == playerScore
      alert "It's a tie!"