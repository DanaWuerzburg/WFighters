package net.wooga.wfighters.controller.gamestate
{
	import net.wooga.wfighters.GameContainer;
	
	public class EndOfRoundGameState extends GameState
	{
		private var koPlayerId : uint;
		
		public function EndOfRoundGameState( gameContainer:GameContainer, koPlayerId : uint )
		{
			super( gameContainer );
			
			this.koPlayerId = koPlayerId;
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Entered end of round game state after player " + koPlayerId + " was KO'd");
			
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
			var winningPlayerId:uint = (koPlayerId == 1) ? 0 : 1;
			gameContainer.playerStatsController.incrementRoundsWon( winningPlayerId );
			
			var roundsWon : uint = gameContainer.playerStatsController.getRoundsWon( winningPlayerId );
			const roundsNeededToWin : uint = gameContainer.gameConfigurationController.roundsPerMatch;
			
			if( roundsWon >= roundsNeededToWin )
			{
				// TODO: transition to a game ended state
				trace("Player " + winningPlayerId + " has won with " + roundsWon + " wins!");
			}
			else
			{
				resetFightForNewRound();
			}
		}
		
		private function resetFightForNewRound() : void
		{
			gameContainer.fightArea.resetFighters();
			gameContainer.gameController.changeGameState( new BeginRoundGameState( gameContainer ) );
		}
	}
}