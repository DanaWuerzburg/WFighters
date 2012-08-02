package net.wooga.wfighters.controller
{
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import net.wooga.wfighters.events.PlaySoundEvent;

	public class SoundController
	{
		private var _eventDispatcher : IEventDispatcher;
		private var _sounds : Dictionary;
		
		public function SoundController( eventDispatcher : IEventDispatcher )
		{
			_eventDispatcher = eventDispatcher;
			
			init();
		}
		
		private function init() : void
		{
			loadSounds();
			
			_eventDispatcher.addEventListener( PlaySoundEvent.TYPE_NAME, onPlaySoundEvent, false, 0, true );
		}
		
		private function onPlaySoundEvent( event : PlaySoundEvent ) : void
		{
			trace("Playing sound: " + event.soundCue);
			
			var sound : Sound = _sounds[ event.soundCue ];
			sound.play();
			// TODO: Manage SoundChannel objects so we can stop playing sound
		}
		
		private function loadSounds() : void
		{
			_sounds = new Dictionary();
			_sounds[ Sounds.START_GAME ] = Assets.createSound( Assets.GuilesThemeSound );
		}
	}
}