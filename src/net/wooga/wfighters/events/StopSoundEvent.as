package net.wooga.wfighters.events 
{
	import flash.events.Event;
	
	public class StopSoundEvent extends Event
	{
		public static const TYPE_NAME : String = "StopSoundEvent";
		
		private var _soundCue : String;
		
		public function StopSoundEvent( soundCue : String )
		{
			super( TYPE_NAME, false, false );
			
			_soundCue = soundCue;
		}
		
		public function get soundCue() : String { return _soundCue; }
	}

}