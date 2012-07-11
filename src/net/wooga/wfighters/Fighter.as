package net.wooga.wfighters 
{
	import flash.display.Sprite;
	
	public class Fighter extends Sprite 
	{
		private static const STATE_STAND : String = "STATE_STAND";
		
		private var _state : String;
		
		public function Fighter() 
		{
			state = STATE_STAND;
		}
		
		public function doPunch() : void
		{
		}
		
		public function doKick() : void
		{
		}
		
		public function startGuard() : void
		{
		}
		
		public function stopGuard() : void
		{
		}
		
		private function set state( state : String ) : void
		{
			_state = state;
			handleStateChanged();
		}
		
		private function handleStateChanged() : void
		{
			switch ( _state )
			{
				case STATE_STAND: break;
			}
		}
	}
}