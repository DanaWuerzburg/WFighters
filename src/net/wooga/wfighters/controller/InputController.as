package net.wooga.wfighters.controller 
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import net.wooga.wfighters.fighter.ControlConfig;
	
	import net.wooga.wfighters.GameContainer;
	
	public class InputController 
	{
		public static var CONTROL_CONFIG_1 : ControlConfig = new ControlConfig();
		CONTROL_CONFIG_1.upKey =	Keyboard.NUMPAD_8;
		CONTROL_CONFIG_1.downKey =	Keyboard.NUMPAD_2;
		CONTROL_CONFIG_1.leftKey =	Keyboard.NUMPAD_4;
		CONTROL_CONFIG_1.rightKey =	Keyboard.NUMPAD_6;
		CONTROL_CONFIG_1.punchKey =	Keyboard.C;
		CONTROL_CONFIG_1.kickKey =	Keyboard.NUMBER_5;
		
		public static var CONTROL_CONFIG_2 : ControlConfig = new ControlConfig();
		CONTROL_CONFIG_2.upKey =	Keyboard.R;
		CONTROL_CONFIG_2.downKey =	Keyboard.F;
		CONTROL_CONFIG_2.leftKey =	Keyboard.D;
		CONTROL_CONFIG_2.rightKey =	Keyboard.G;
		CONTROL_CONFIG_2.punchKey =	Keyboard.RIGHTBRACKET;
		CONTROL_CONFIG_2.kickKey =	Keyboard.NUMBER_6;
		
		private var _inputEnabled : Boolean = true;
		private var keyCodeVector : Vector.<Boolean> = new Vector.<Boolean>;
		private var numPressedKeys : int = 0;
		private var triggeredKeys : Dictionary = new Dictionary();
		
		public function get inputEnabled() : Boolean { return _inputEnabled; }
		public function set inputEnabled( value : Boolean ) : void { _inputEnabled = value; }
		
		public function isKeyPressed( keyCode : uint ) : Boolean
		{
			return inputEnabled && keyCodeVector.length > keyCode ? keyCodeVector[ keyCode ] : false;
		}
		
		public function isKeyTriggered( key : uint ) : Boolean
		{
			var wasPressed : Boolean = triggeredKeys[ key ];
			triggeredKeys[ key ] = isKeyPressed( key );
			return !wasPressed && triggeredKeys[ key ];
		}
		
		public function isAnyKeyPressed() : Boolean
		{
			return inputEnabled && numPressedKeys > 0;
		}
		
		public function handleKeyDown( e : KeyboardEvent ) : void 
		{
			ensureKeyVectorSize( e.keyCode );
			keyCodeVector[ e.keyCode ] = true;
			numPressedKeys++;
		}
		
		public function handleKeyUp( e : KeyboardEvent ) : void 
		{
			ensureKeyVectorSize( e.keyCode );
			keyCodeVector[ e.keyCode ] = false;
			numPressedKeys--;
		}
		
		private function ensureKeyVectorSize( keyCode : uint ) : void
		{
			while ( keyCodeVector.length <= keyCode )
			{
				keyCodeVector.push( false );
			}
		}
	}

}