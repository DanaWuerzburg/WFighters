package net.wooga.wfighters 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import net.wooga.wfighters.controller.GameController;
	import net.wooga.wfighters.controller.InputController;
	import net.wooga.wfighters.controller.SoundController;
	import net.wooga.wfighters.controller.gameconfig.GameConfigurationController;
	import net.wooga.wfighters.controller.player.PlayerStatsController;
	import net.wooga.wfighters.events.FighterWonRoundEvent;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.gui.FightHUD;
	
	public class GameContainer extends Sprite
	{
		private var pressedKeys : Dictionary;
		private var _gameController : GameController;
		private var _inputController : InputController;
		private var _playerStatsController : PlayerStatsController;
		private var _gameConfigurationController : GameConfigurationController;
		private var _soundController : SoundController;
		private var _fightArea : FightArea;
		private var _standardTextFormat : TextFormat;
		private var _bigTextFormat : TextFormat;
		private var _fightHud : FightHUD;
		
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
		
		public function createBigTextField() : TextField
		{
			var textField : TextField = new TextField();
			textField.defaultTextFormat = bigTextFormat;
			textField.embedFonts = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			return textField;
		}
		
		public function resetGame() : void
		{
			stage.removeEventListener( Event.ENTER_FRAME, handleEnterFrame );
			
			while( this.numChildren > 0 )
			{
				removeChildAt( 0 );
			}
			
			init();
		}
		
		public function get inputController() : InputController
		{
			return _inputController;
		}
		
		public function get gameController() : GameController
		{
			return _gameController;
		}
		
		public function get playerStatsController() : PlayerStatsController
		{
			return _playerStatsController;
		}
		
		public function get gameConfigurationController() : GameConfigurationController
		{
			return _gameConfigurationController;
		}
		
		public function get fightArea() : FightArea
		{
			return _fightArea;
		}
		
		public function get fightHud() : FightHUD
		{
			return _fightHud;
		}
		
		public function get standardTextFormat() : TextFormat
		{
			return _standardTextFormat;
		}
		
		public function get bigTextFormat() : TextFormat
		{
			return _bigTextFormat;
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
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.fullScreenSourceRect = new Rectangle( 0, 0, 640, 480 );
			
			init();
		}
		
		private function init() : void
		{
			_fightArea = new FightArea();
			addChild( _fightArea );
			
			_fightHud = new FightHUD();
			addChild( _fightHud );
			
			_soundController = new SoundController( this.stage );
			_gameController = new GameController( this );
			_inputController = new InputController();
			_playerStatsController = new PlayerStatsController( this.stage );
			_gameConfigurationController = new GameConfigurationController();
			
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
			
			_bigTextFormat = new TextFormat( "grilcb", 40 );
			_bigTextFormat.color = 0xFFFFFF;
		}
	}

}