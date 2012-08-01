package net.wooga.wfighters.controller.gamestate
{
	import net.wooga.wfighters.GameContainer;
	
	public class FightingGameState extends GameState
	{
		public function FightingGameState(gameContainer:GameContainer)
		{
			super(gameContainer);
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Fighting game state active");
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			gameContainer.fightArea.update( t );
			
			// TODO: Check for player KO here rather than in Fighter class
		}
	}
}