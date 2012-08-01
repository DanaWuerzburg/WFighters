package net.wooga.wfighters.controller.gamestate
{
	import net.wooga.wfighters.GameContainer;
	
	public class EndOfRoundGameState extends GameState
	{
		public function EndOfRoundGameState(gameContainer:GameContainer)
		{
			super(gameContainer);
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Entered end of round game state");
			
			// TODO: Display "round over"
			
			checkWinConditions();
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			
		}
		
		private function checkWinConditions() : void
		{
			// TODO: complete
			
			// if a player has won enough rounds to win...
				// transition to a game ended state
			// otherwise...
				// reset fighters
				// begin new round
			
			resetFightForNewRound();
		}
		
		private function resetFightForNewRound() : void
		{
			gameContainer.fightArea.resetFighters();
			gameContainer.gameController.changeGameState( new BeginRoundGameState( gameContainer ) );
		}
	}
}