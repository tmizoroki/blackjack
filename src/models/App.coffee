# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'stand', =>
      (@get 'dealerHand').at(0).flip()
      (@get 'dealerHand').trigger("reveal")

    (@get 'dealerHand').on 'dealerDone', =>
      @whoWon()
    (@get 'playerHand').on 'bust', =>
      @whoWon()
    (@get 'playerHand').on 'blackjack', =>
      @blackjackWin()

  whoWon:  ->

    playerScore = (@get 'playerHand').score
    dealerScore = (@get 'dealerHand').score

    if playerScore > 21
      @trigger 'youbust', @
    else if playerScore > dealerScore
      @trigger 'youwin', @
    else if dealerScore > 21
      @trigger 'youwin', @
    else if dealerScore > playerScore
      @trigger 'dealerwin', @
    else if dealerScore == playerScore
      @trigger 'tie', @

  blackjackWin: ->
    playerScore = (@get 'playerHand').score
    dealerScore = (@get 'dealerHand').score

    if dealerScore != 21
      @trigger 'blackjack', @
      (@get 'dealerHand').at(0).flip()
      (@get 'dealerHand').trigger("reveal")
    else
      @trigger 'blackjacktie', @
      (@get 'dealerHand').at(0).flip()
      (@get 'dealerHand').trigger("reveal")