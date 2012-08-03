package net.wooga.wfighters.controller.gamestate.woogascreen 
{
	import flash.display.Bitmap;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.StartGameState;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.events.PlaySoundEvent;
	import net.wooga.wfighters.GameContainer;
	
	public class WoogaScreenGameState extends GameState
	{
		private var wooga : Bitmap;
		private var time : Number;
		private var step : int;
		
		public function WoogaScreenGameState( gameContainer : GameContainer ) 
		{
			super( gameContainer );
			
			wooga = new Assets.WoogaBitmap();
		}
		
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( wooga );
			wooga.alpha = 0;
			time = 0;
			step = 0;
			gameContainer.fightArea.visible = false;
			gameContainer.fightHud.visible = false;
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( wooga );
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			if ( step == 0 )
			{
				wooga.alpha = Math.min( 1, time / 200 );
				if ( time > 500 )
				{
					step = 1;
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.WOOGA_GROUP ) );
				}
			}
			else if ( step == 1 )
			{
				if ( time > 4000 )
				{
					step = 2;
				}
			}
			else if ( step == 2 )
			{
				wooga.alpha = Math.max( 0, 1 - ( time - 4000 ) / 200 );
				if ( time > 4500 )
				{
					gameContainer.gameController.changeGameState( new StartGameState( gameContainer ) );
				}
			}
			
		}
	}

}