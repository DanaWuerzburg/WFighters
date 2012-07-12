package net.wooga.wfighters 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import net.wooga.wfighters.controller.GameController;
	import net.wooga.wfighters.controller.InputController;
	
	public class GameContainer extends Sprite
	{
		private var pressedKeys : Dictionary;
		private var _gameController : GameController;
		private var _inputController : InputController;
		
		public function GameContainer() 
		{
			super();
			
			pressedKeys = new Dictionary();
			
			setup();
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToState );
		}
		
		public function get inputController() : InputController
		{
			return _inputController;
		}
		
		private function setup() : void
		{
			graphics.beginFill( 0x000000 );
			graphics.drawRect( 0, 0, 640, 480 )
			graphics.endFill();
		}
		
		private function handleAddedToState( e : Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToState );
			
			_gameController = new GameController( this );
			_inputController = new InputController();
			stage.addEventListener( KeyboardEvent.KEY_DOWN, _inputController.handleKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, _inputController.handleKeyUp );
			
			stage.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		private function handleEnterFrame( e : Event ) : void
		{
			_gameController.update();
		}
	}

}