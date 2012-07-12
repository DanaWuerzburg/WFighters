package net.wooga.wfighters.controller 
{
	import flash.events.KeyboardEvent;
	import net.wooga.wfighters.GameContainer;
	public class InputController 
	{
		private var keyCodeVector : Vector.<Boolean> = new Vector.<Boolean>;
		
		public function isKeyPressed( keyCode : uint ) : Boolean
		{
			return keyCodeVector.length > keyCode ? keyCodeVector[ keyCode ] : false;
		}
		
		public function handleKeyDown( e : KeyboardEvent ) : void 
		{
			ensureKeyVectorSize( e.keyCode );
			keyCodeVector[ e.keyCode ] = true;
		}
		
		public function handleKeyUp( e : KeyboardEvent ) : void 
		{
			ensureKeyVectorSize( e.keyCode );
			keyCodeVector[ e.keyCode ] = false;
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