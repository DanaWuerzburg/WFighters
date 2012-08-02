package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.events.FighterKOdEvent;
	import net.wooga.wfighters.events.PlaySoundEvent;
	
	public class FightingGameState extends GameState
	{
		private const FIGHT_TEXT_DURATION : int = 1500;
		
		private var fightGraphic : Bitmap;
		private var elapsedTime : int = 0;
		
		public function FightingGameState(gameContainer:GameContainer)
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Fighting game state active");
			
			gameContainer.stage.addEventListener( FighterKOdEvent.TYPE_NAME, onFighterKOd );
			
			setUpFightGraphic();
			gameContainer.addChild( fightGraphic );
			
			gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_FIGHT ) );
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( fightGraphic );
		}
		
		public override function update( t : int ) : void
		{
			elapsedTime += t;
			
			if( fightGraphic.visible && elapsedTime > FIGHT_TEXT_DURATION )
				fightGraphic.visible = false;
			
			gameContainer.fightArea.update( t );
		}
		
		private function onFighterKOd( event : FighterKOdEvent ) : void
		{
			gameContainer.stage.removeEventListener( FighterKOdEvent.TYPE_NAME, onFighterKOd );
			gameContainer.gameController.changeGameState( new KOGameState( gameContainer, event.playerId ) );
		}
		
		private function setUpFightGraphic() : void
		{
			fightGraphic = Assets.createBitmap( Assets.FightBitmap );
			
			var stageCenterX : Number = gameContainer.stage.stageWidth / 2;
			var stageCenterY : Number = gameContainer.stage.stageHeight / 2;
			var halfImageWidth : Number = fightGraphic.width / 2;
			var halfImageHeight : Number = fightGraphic.height / 2;
			fightGraphic.x = stageCenterX - halfImageWidth;
			fightGraphic.y = stageCenterY - halfImageHeight;
		}
	}
}