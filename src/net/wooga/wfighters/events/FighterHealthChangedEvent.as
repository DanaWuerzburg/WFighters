package net.wooga.wfighters.events
{
	import flash.events.Event;
	
	public class FighterHealthChangedEvent extends Event
	{
		public static const TYPE_NAME : String = "FighterHealthChanged";
		
		private var _playerId : uint;
		private var _healthPercent : Number;
		
		public function FighterHealthChangedEvent( playerId : uint, currentHealthPercent : Number )
		{
			super( TYPE_NAME, false, false );
			
			_playerId = playerId;
			_healthPercent = currentHealthPercent;
		}
		
		public function get playerId() : uint
		{
			return _playerId;
		}
		
		public function get currentHealthPercent() : Number
		{
			return _healthPercent;
		}
	}
}