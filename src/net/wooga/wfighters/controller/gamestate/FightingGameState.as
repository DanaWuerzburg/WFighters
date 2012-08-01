package net.wooga.wfighters.controller.gamestate
{
	import flash.events.IEventDispatcher;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.events.FighterKOdEvent;
	
	public class FightingGameState extends GameState
	{
		public function FightingGameState(gameContainer:GameContainer)
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Fighting game state active");
			
			gameContainer.addEventListener( FighterKOdEvent.TYPE_NAME, onFighterKOd );
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			gameContainer.fightArea.update( t );
		}
		
		private function onFighterKOd( event : FighterKOdEvent ) : void
		{
			gameContainer.removeEventListener( FighterKOdEvent.TYPE_NAME, onFighterKOd );
			gameContainer.gameController.changeGameState( new KOGameState( gameContainer, event.playerId ) );
		}
	}
}