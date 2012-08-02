package net.wooga.wfighters.controller.gamestate.versusscreen 
{
	import flash.display.Bitmap;
	import net.wooga.wfighters.controller.gamestate.characterselect.CharacterSet;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.vsmatch.ConfigureFightersGameState;
	import net.wooga.wfighters.GameContainer;
	
	public class VersusScreenGameState extends GameState 
	{
		private var sun : Bitmap;
		private var fire : Bitmap;
		private var vs : Bitmap;
		private var player1Bitmap : Bitmap;
		private var player2Bitmap : Bitmap;
		private var player1 : CharacterSet;
		private var player2 : CharacterSet;
		
		private var time : Number;
		
		public function VersusScreenGameState( gameContainer:GameContainer, player1 : CharacterSet, player2 : CharacterSet ) 
		{
			super(gameContainer);
			this.player1 = player1;
			this.player2 = player2;
			sun = new Assets.VersusScreenSunBitmap();
			vs = new Assets.VersusScreenVSBitmap();
			fire = new Assets.VersusScreenFireBitmap();
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( sun );
			gameContainer.addChild( fire );
			gameContainer.addChild( vs );
			
			time = 0;
			
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( sun );
			gameContainer.removeChild( fire );
			gameContainer.removeChild( vs );
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			gameContainer.gameController.changeGameState(
					new ConfigureFightersGameState(
						gameContainer,
						player1.characterClass,
						player2.characterClass
						)
					);
			
		}
	}
}