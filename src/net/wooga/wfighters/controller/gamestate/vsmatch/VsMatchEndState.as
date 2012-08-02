package net.wooga.wfighters.controller.gamestate.vsmatch
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.StartGameState;
	
	public class VsMatchEndState extends GameState
	{
		private const TIME_UNTIL_EXIT : int = 3000;
		
		private var _winningPlayerId : uint;
		private var _timeElapsed : int;
		private var _drawingArea : Sprite;
		private var _textField : TextField;
		
		public function VsMatchEndState( gameContainer:GameContainer, winningPlayerId : uint )
		{
			super( gameContainer );
			
			_winningPlayerId = winningPlayerId;
			_drawingArea = new Sprite();
			setUpTextField();
			_drawingArea.addChild( _textField );
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Player " + _winningPlayerId + " has won!");
			
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
				gameContainer.gameController.changeGameState( new StartGameState( gameContainer ) );
			}
		}
		
		private function setUpTextField() : void
		{
			var winningPlayer : String = (_winningPlayerId + 1).toString();
			_textField = gameContainer.createBigTextField( 0xFF0000 );
			_textField.text = "Player " + winningPlayer + " wins!";
			
			_textField.x = (gameContainer.stage.stageWidth / 2) - (_textField.width / 2);
			_textField.y = (gameContainer.stage.stageHeight / 2) - (_textField.height / 2);
		}
	}
}