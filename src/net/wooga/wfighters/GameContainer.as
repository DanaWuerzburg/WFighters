package net.wooga.wfighters 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import net.wooga.wfighters.controller.GameController;
	import net.wooga.wfighters.controller.InputController;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.gui.HPGauge;
	
	public class GameContainer extends Sprite
	{
		private var pressedKeys : Dictionary;
		private var _gameController : GameController;
		private var _inputController : InputController;
		private var _fightArea : FightArea;
		private var _hpGauge : HPGauge;
		private var _standardTextFormat : TextFormat;
		
		public function GameContainer() 
		{
			super();
			
			pressedKeys = new Dictionary();
			
			setup();
			setupTextFormats();
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToState );
		}
		
		public function createStandardTextField() : TextField
		{
			var textField : TextField = new TextField();
			textField.defaultTextFormat = standardTextFormat;
			textField.embedFonts = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			return textField;
		}
		
		public function get inputController() : InputController
		{
			return _inputController;
		}
		
		public function get gameController() : GameController
		{
			return _gameController;
		}
		
		public function get fightArea() : FightArea
		{
			return _fightArea;
		}
		
		public function get hpGauge() : HPGauge
		{
			return _hpGauge;
		}
		
		public function get standardTextFormat() : TextFormat
		{
			return _standardTextFormat;
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
			
			_fightArea = new FightArea();
			addChild( _fightArea );
			_hpGauge = new HPGauge();
			addChild( _hpGauge );
			
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
		
		private function setupTextFormats() : void
		{
			_standardTextFormat = new TextFormat( "Joystix", 20 );
			_standardTextFormat.color = 0xFFFFFF;
		}
	}

}