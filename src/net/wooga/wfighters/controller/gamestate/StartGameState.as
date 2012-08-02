package net.wooga.wfighters.controller.gamestate 
{
	import flash.display.Bitmap;
	import flash.text.TextField;
	import net.wooga.wfighters.controller.gamestate.characterselect.CharacterSelectGameState;
	import net.wooga.wfighters.GameContainer;
	
	public class StartGameState extends GameState 
	{	
		private var textField : TextField;
		private var time : Number;
		private var titleBitmap : Bitmap;
		private var fadeOut : Boolean = false;
		
		public function StartGameState( gameContainer:GameContainer )
		{
			super( gameContainer );
			
		}
		
		override public function handleBecomeActive() : void 
		{
			super.handleBecomeActive();
			
			titleBitmap = new Assets.StartScreenBitmap() as Bitmap;
			gameContainer.addChild( titleBitmap );
			
			textField = gameContainer.createStandardTextField();
			textField.text = "Press any key!";
			textField.x = 320 - textField.width / 2;
			textField.y = 400;
			gameContainer.addChild( textField );
			
			gameContainer.fightArea.visible = false;
			gameContainer.fightHud.visible = false;
			
			time = 0;
		}
		
		override public function handleResignActive():void 
		{
			super.handleResignActive();
			
			gameContainer.removeChild( textField );
			gameContainer.removeChild( titleBitmap );
		}
		
		override public function update( t : int ):void 
		{
			super.update( t );
			
			time += t;
			
			if ( fadeOut )
			{
				if ( time >= 1000 )
				{
					gameContainer.gameController.changeGameState( new CharacterSelectGameState( gameContainer ) );
				}
				else
				{
					textField.visible = time % 200 > 100;
					titleBitmap.alpha = 1 - ( time / 1000 );
				}
			}
			else
			{
				textField.visible = time % 1000 > 500;
				
				if ( gameContainer.inputController.isAnyKeyPressed() )
				{
					fadeOut = true;
					time = 0;
				}
			}
		}
	}
}