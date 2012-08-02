package net.wooga.wfighters.controller.gamestate
{
	import net.wooga.wfighters.GameContainer;
	
	public class VsMatchEndState extends GameState
	{
		private var _winningPlayerId : uint;
		
		public function VsMatchEndState( gameContainer:GameContainer, winningPlayerId : uint )
		{
			super( gameContainer );
			
			_winningPlayerId = winningPlayerId;
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Player " + _winningPlayerId + " has won!");
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			
		}
	}
}