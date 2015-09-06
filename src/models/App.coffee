# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: (restart) ->
    if !restart
      console.log "new deck!"
      @set 'deck', deck = new Deck()
    else
      deck = @get 'deck'
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'stand', =>
      (@get 'dealerHand').at(0).flip()
      (@get 'dealerHand').trigger("reveal")

    (@get 'dealerHand').on 'dealerDone', =>
      console.log "Dealer done"
      @whoWon()
    (@get 'playerHand').on 'bust', =>
      @whoWon()
    (@get 'playerHand').on 'blackjack', =>
      @blackjackWin()
    (@get 'deck').on 'reshuffled', ->
      @trigger "reshuffled"
      console.log "Reshuffled received!"

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

  restart: ->
    console.log "restarting..."