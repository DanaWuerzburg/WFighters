package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.StartGameState;
	
	public class VsMatchEndState extends GameState
	{
		private const TIME_UNTIL_EXIT : int = 3000;
		
		private var _winningPlayerId : uint;
		private var _timeElapsed : int;
		
		public function VsMatchEndState( gameContainer:GameContainer, winningPlayerId : uint )
		{
			super( gameContainer );
			
			_winningPlayerId = winningPlayerId;
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Player " + _winningPlayerId + " has won!");
			
			gameContainer.inputController.inputEnabled = false;
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.inputController.inputEnabled = true;
		}
		
		public override function update( t : int ) : void
		{
			_timeElapsed += t;
			
			gameContainer.fightArea.update( t );
			
			if( _timeElapsed > TIME_UNTIL_EXIT )
			{
				gameContainer.resetGame();
				gameContainer.gameController.changeGameState( new StartGameState( gameContainer ) );
			}
		}
	}
}