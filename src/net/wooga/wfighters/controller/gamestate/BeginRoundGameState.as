package net.wooga.wfighters.controller.gamestate
{
	import net.wooga.wfighters.GameContainer;
	
	/**
	 * Handles beginning a round, e.g. "ready... fight!"
	 */
	public class BeginRoundGameState extends GameState
	{
		private var roundIntroAnimationFinished : Boolean = false;
		
		public function BeginRoundGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Begin round game state active");
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			// TODO: Display "Ready... fight!" text
			roundIntroAnimationFinished = true;
			
			if( roundIntroAnimationFinished )
				gameContainer.gameController.changeGameState( new FightingGameState( gameContainer ) );
		}
	}
}