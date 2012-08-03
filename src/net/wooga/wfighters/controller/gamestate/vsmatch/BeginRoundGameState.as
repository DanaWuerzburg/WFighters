package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.player.PlayerStatsController;
	import net.wooga.wfighters.events.PlaySoundEvent;
	
	/**
	 * Handles beginning a round, e.g. "round one... fight!"
	 */
	public class BeginRoundGameState extends GameState
	{
		private const TIME_TO_DISPLAY_ROUND_NUMBER : uint = 1500;
		
		private var timeElapsed : int = 0;
		private var roundIntroAnimationFinished : Boolean = false;
		private var roundImage : Bitmap;
		
		public function BeginRoundGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
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
			
			if ( isRoundIntroAnimationFinished() )
			{
				gameContainer.gameController.changeGameState( new FightingGameState( gameContainer ) );
				gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.STAGE_BGM, 0.3 ) );
			}
		}
		
		private function setUpRoundNumberImage() : void
		{
			var roundNumber : uint = calcRoundNumber();
			switch( roundNumber )
			{
				case 1:
					roundImage = Assets.createBitmap( Assets.RoundOneBitmap );
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_ROUND_ONE ) );
					break;
				case 2:
					roundImage = Assets.createBitmap( Assets.RoundTwoBitmap );
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_ROUND_TWO ) );
					break;
				case 3:
					roundImage = Assets.createBitmap( Assets.RoundThreeBitmap );
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_ROUND_THREE ) );
					break;
				case 4:
					trace("WARNING: Need a round 4 image");
					roundImage = new Bitmap(); // Use dummy data so the game doesn't crash
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_ROUND_FOUR ) );
					break;
				case 5:
					trace("Warning: Need a round 5 image");
					roundImage = new Bitmap(); // Use dummy data so the game doesn't crash
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_ROUND_FIVE ) );
					break;
				default:
					trace("ERROR: Round " + roundNumber + " out of range in BeginRoundGameState.handleBecomeActive");
					roundImage = new Bitmap(); // Use dummy data so the game doesn't crash
					break;
			}
			
			var stageCenterX : Number = gameContainer.stage.stageWidth / 2;
			var stageCenterY : Number = gameContainer.stage.stageHeight / 2;
			var halfImageWidth : Number = roundImage.width / 2;
			var halfImageHeight : Number = roundImage.height / 2;
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