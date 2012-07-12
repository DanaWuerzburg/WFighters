package net.wooga.wfighters.controller.gamestate 
{
	import net.wooga.wfighters.Fighter;
	import net.wooga.wfighters.GameContainer;
	public class FightIntroGameState extends GameState 
	{		
		private var introTime : Number = 0;
		private var fighterOne : Fighter;
		
		public function FightIntroGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( fighterOne = new Fighter( gameContainer ) );
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			introTime += t;
			fighterOne.update( t );
		}
	}
}