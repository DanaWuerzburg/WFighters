package net.wooga.wfighters.events
{
	import flash.events.Event;
	
	public class PlaySoundEvent extends Event
	{
		public static const TYPE_NAME : String = "PlaySoundEvent";
		
		private var _soundCue : String;
		
		public function PlaySoundEvent( soundCue : String )
		{
			super( TYPE_NAME, false, false );
			
			_soundCue = soundCue;
		}
		
		public function get soundCue() : String { return _soundCue; }
	}
}