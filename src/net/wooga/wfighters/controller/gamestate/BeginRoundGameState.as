package net.wooga.wfighters.controller.gamestate
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.player.PlayerStatsController;
	
	/**
	 * Handles beginning a round, e.g. "round one... fight!"
	 */
	public class BeginRoundGameState extends GameState
	{
		private const TIME_TO_DISPLAY_ROUND_NUMBER : uint = 1500;
		
		private var timeElapsed : int = 0;
		private var roundIntroAnimationFinished : Boolean = false;
		private var roundImage : Sprite;
		
		public function BeginRoundGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
			
			roundImage = new Sprite();
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Begin round game state active");
			
			// Disable input
			gameContainer.inputController.inputEnabled = false;
			
			// Display round number image
			setUpRoundNumberImage();
			gameContainer.addChild( roundImage );
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( roundImage );
			gameContainer.inputController.inputEnabled = true;
		}
		
		public override function update( t : int ) : void
		{
			timeElapsed += t;
			
			gameContainer.fightArea.update( t );
			
			if( isRoundIntroAnimationFinished() )
				gameContainer.gameController.changeGameState( new FightingGameState( gameContainer ) );
		}
		
		private function setUpRoundNumberImage() : void
		{
			var roundNumber : uint = calcRoundNumber();
			var roundNumberImage : BitmapData;
			switch( roundNumber )
			{
				case 1:
					roundNumberImage = (new Assets.RoundOneBitmap() as Bitmap).bitmapData;
					break;
				case 2:
					roundNumberImage = (new Assets.RoundTwoBitmap() as Bitmap).bitmapData;
					break;
				case 3:
					roundNumberImage = (new Assets.RoundThreeBitmap() as Bitmap).bitmapData;
					break;
				default:
					trace("ERROR: Round " + roundNumber + " out of range in BeginRoundGameState.handleBecomeActive");
					roundNumberImage = new BitmapData( 0, 0 ); // Use dummy data so the game doesn't crash
					break;
			}
			
			roundImage.graphics.beginBitmapFill( roundNumberImage );
			roundImage.graphics.drawRect( 0, 0, roundNumberImage.width, roundNumberImage.height );
			roundImage.graphics.endFill();
			
			var stageCenterX : Number = gameContainer.stage.stageWidth / 2;
			var stageCenterY : Number = gameContainer.stage.stageHeight / 2;
			var halfImageWidth : Number = roundNumberImage.width / 2;
			var halfImageHeight : Number = roundNumberImage.height / 2;
			roundImage.x = stageCenterX - halfImageWidth;
			roundImage.y = stageCenterY - halfImageHeight;
		}
		
		private function calcRoundNumber() : int
		{
			var stats : PlayerStatsController = gameContainer.playerStatsController;
			var numRoundsFinished : int = stats.getRoundsWon( 0 ) + stats.getRoundsWon( 1 );
			
			return numRoundsFinished + 1;
		}
		
		private function isRoundIntroAnimationFinished() : Boolean
		{
			return timeElapsed >= TIME_TO_DISPLAY_ROUND_NUMBER;
		}
	}
}