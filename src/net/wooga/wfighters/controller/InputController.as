package net.wooga.wfighters.controller 
{
	import flash.events.KeyboardEvent;
	
	import net.wooga.wfighters.GameContainer;
	
	public class InputController 
	{
		private var _inputEnabled : Boolean = true;
		private var keyCodeVector : Vector.<Boolean> = new Vector.<Boolean>;
		private var numPressedKeys : int = 0;
		
		public function get inputEnabled() : Boolean { return _inputEnabled; }
		public function set inputEnabled( value : Boolean ) : void { _inputEnabled = value; }
		
		public function isKeyPressed( keyCode : uint ) : Boolean
		{
			return inputEnabled && keyCodeVector.length > keyCode ? keyCodeVector[ keyCode ] : false;
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