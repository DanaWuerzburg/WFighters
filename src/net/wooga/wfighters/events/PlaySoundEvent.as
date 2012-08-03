package net.wooga.wfighters.events
{
	import flash.events.Event;
	
	public class PlaySoundEvent extends Event
	{
		public static const TYPE_NAME : String = "PlaySoundEvent";
		
		private var _soundCue : String;
		private var _volume : Number;
		
		public function PlaySoundEvent( soundCue : String, volume : Number = 1 )
		{
			super( TYPE_NAME, false, false );
			
			_soundCue = soundCue;
			_volume = volume;
		}
		
		public function get soundCue() : String { return _soundCue; }
		public function get volume() : Number { return _volume; }
	}
}