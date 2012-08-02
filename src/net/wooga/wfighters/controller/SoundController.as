package net.wooga.wfighters.controller
{
	import flash.events.IEventDispatcher;
	
	import net.wooga.wfighters.events.PlaySoundEvent;

	public class SoundController
	{
		private var _eventDispatcher : IEventDispatcher;
		
		public function SoundController( eventDispatcher : IEventDispatcher )
		{
			_eventDispatcher = eventDispatcher;
			
			init();
		}
		
		private function init() : void
		{
			_eventDispatcher.addEventListener( PlaySoundEvent.TYPE_NAME, onPlaySoundEvent, false, 0, true );
		}
		
		private function onPlaySoundEvent( event : PlaySoundEvent ) : void
		{
			// TODO: Play sound
			trace("Playing sound: " + event.soundCue);
		}
	}
}