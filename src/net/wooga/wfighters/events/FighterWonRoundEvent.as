package net.wooga.wfighters.events
{
	import flash.events.Event;
	
	public class FighterWonRoundEvent extends Event
	{
		public static const TYPE_NAME : String = "FighterWonRoundEvent";
		
		private var _playerId : uint;
		
		public function FighterWonRoundEvent( playerId : uint )
		{
			super( TYPE_NAME, false, false );
			
			_playerId = playerId;
		}
		
		public function get playerId() : uint { return _playerId; }
	}
}