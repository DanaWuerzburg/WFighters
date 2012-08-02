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
			_sounds[ Sounds.MENU_OK1 ] = Assets.createSound( Assets.MenuOk1Sound );
			_sounds[ Sounds.MENU_OK2 ] = Assets.createSound( Assets.MenuOk2Sound );
			_sounds[ Sounds.MENU_SELECT ] = Assets.createSound( Assets.MenuSelectSound );
			_sounds[ Sounds.VERSUS_DRAMATIC_DRUM ] = Assets.createSound( Assets.VersusDramaticDrumSound );
			_sounds[ Sounds.VERSUS_BOOM ] = Assets.createSound( Assets.VersusBoomSound );
			_sounds[ Sounds.VERSUS_BOOM ] = Assets.createSound( Assets.VersusBoomSound );
			_sounds[ Sounds.FIGHT_PUNCH01 ] = Assets.createSound( Assets.FightPunch01Sound );
			_sounds[ Sounds.FIGHT_PUNCH02 ] = Assets.createSound( Assets.FightPunch02Sound );
			_sounds[ Sounds.FIGHT_PUNCH03 ] = Assets.createSound( Assets.FightPunch03Sound );
			_sounds[ Sounds.FIGHT_PUNCH04 ] = Assets.createSound( Assets.FightPunch04Sound );
			_sounds[ Sounds.FIGHT_PUNCH05 ] = Assets.createSound( Assets.FightPunch05Sound );
			_sounds[ Sounds.FIGHT_PUNCH06 ] = Assets.createSound( Assets.FightPunch06Sound );
			_sounds[ Sounds.FIGHT_PUNCH07 ] = Assets.createSound( Assets.FightPunch07Sound );
			_sounds[ Sounds.FIGHT_PUNCH08 ] = Assets.createSound( Assets.FightPunch08Sound );
			_sounds[ Sounds.FIGHT_PUNCH09 ] = Assets.createSound( Assets.FightPunch09Sound );
			_sounds[ Sounds.FIGHT_GROUND01 ] = Assets.createSound( Assets.FightGround01Sound );
			_sounds[ Sounds.FIGHT_GROUND02 ] = Assets.createSound( Assets.FightGround02Sound );
			_sounds[ Sounds.FIGHT_GROUND03 ] = Assets.createSound( Assets.FightGround03Sound );
		}
	}
}