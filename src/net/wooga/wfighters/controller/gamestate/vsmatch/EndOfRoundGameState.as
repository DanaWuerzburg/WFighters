package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.events.FighterWonRoundEvent;
	import net.wooga.wfighters.controller.gamestate.GameState;
	
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
			gameContainer.stage.dispatchEvent( new FighterWonRoundEvent( winningPlayerId ) );
			
			var roundsWon : uint = gameContainer.playerStatsController.getRoundsWon( winningPlayerId );
			const roundsNeededToWin : uint = gameContainer.gameConfigurationController.roundsPerMatch;
			
			if( roundsWon >= roundsNeededToWin )
			{
				endMatch( winningPlayerId );
			}
			else
			{
				resetFightForNewRound();
			}
		}
		
		private function endMatch( winningPlayerId : uint ) : void
		{
			gameContainer.gameController.changeGameState( new VsMatchEndState( gameContainer, winningPlayerId ) );
		}
		
		private function resetFightForNewRound() : void
		{
			gameContainer.fightArea.resetFighters();
			gameContainer.gameController.changeGameState( new BeginRoundGameState( gameContainer ) );
		}
	}
}