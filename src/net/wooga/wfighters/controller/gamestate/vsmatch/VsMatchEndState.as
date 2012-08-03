package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.woogascreen.WoogaScreenGameState;
	import net.wooga.wfighters.events.PlaySoundEvent;
	
	public class VsMatchEndState extends GameState
	{
		private const TIME_UNTIL_EXIT : int = 6000;
		
		private var _winningPlayerId : uint;
		private var _timeElapsed : int;
		private var _drawingArea : Sprite;
		private var _playerWinsImage : Bitmap;
		
		public function VsMatchEndState( gameContainer:GameContainer, winningPlayerId : uint )
		{
			super( gameContainer );
			
			_winningPlayerId = winningPlayerId;
			_drawingArea = new Sprite();
			setUpText();
		}
		
		public override function handleBecomeActive() : void
		{	
			playWinSound();
			gameContainer.inputController.inputEnabled = false;
			gameContainer.addChild( _drawingArea );
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( _drawingArea );
			gameContainer.inputController.inputEnabled = true;
		}
		
		public override function update( t : int ) : void
		{
			_timeElapsed += t;
			
			gameContainer.fightArea.update( t );
			
			if( _timeElapsed > TIME_UNTIL_EXIT )
			{
				gameContainer.resetGame();
				gameContainer.gameController.changeGameState( new WoogaScreenGameState( gameContainer ) );
			}
		}
		
		private function setUpText() : void
		{
			switch( _winningPlayerId )
			{
				case 0:
					_playerWinsImage = Assets.createBitmap( Assets.PlayerOneWinsBitmap );
					break;
				case 1:
				default:
					_playerWinsImage = Assets.createBitmap( Assets.PlayerTwoWinsBitmap );
			}
			
			_playerWinsImage.x = (gameContainer.stage.stageWidth / 2) - (_playerWinsImage.width / 2);
			_playerWinsImage.y = (gameContainer.stage.stageHeight / 2) - (_playerWinsImage.height / 2);
			_drawingArea.addChild( _playerWinsImage );
		}
		
		private function playWinSound() : void
		{
			switch( _winningPlayerId )
			{
				case 0:
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_PLAYER_ONE_WINS ) );
					break;
				case 1:
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_PLAYER_TWO_WINS ) );
					break;
				default:
					trace("Unknown winning player id at end of match: " + _winningPlayerId);
					break;
			}
		}
	}
}