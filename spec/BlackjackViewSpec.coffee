expect = chai.expect

describe 'HandView', ->
  deck = null
  hand = null
  handView = null
  appView = null

  beforeEach ->

    deck = new Deck()
    appView = new AppView(model: new App())
    hand = deck.dealPlayer()
    handView = new HandView({collection: hand})
    return


  describe 'rendering', ->
    it 'should render on initial start', ->
      sinon.spy(HandView.prototype, 'render')
      expect(HandView.render).to.have.been.called

    it 'should render on hit click', ->
      appView.$el.children().find('hit-button').click()
      sinon.spy(Hand.prototype, 'hit')
      expect(handView.render).to.have.been.called
