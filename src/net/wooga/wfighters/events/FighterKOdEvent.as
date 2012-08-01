package net.wooga.wfighters.events
{
	import flash.events.Event;
	
	/**
	 * Dispatched when a fighter is KO'd
	 */
	public class FighterKOdEvent extends Event
	{
		public static const TYPE_NAME : String = "FighterKOdEvent";
		
		private var _playerId : int;
		
		public function FighterKOdEvent( playerId : Number )
		{
			super(TYPE_NAME);
			
			_playerId = playerId;
		}
		
		public function get playerId() : int { return _playerId; }
	}
}