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
			
			/* Voiceover */
			_sounds[ Sounds.WOOGA_FIGHTER ] = Assets.createSound( Assets.WoogaFighterSound );
			_sounds[ Sounds.WOOGA_GROUP ] = Assets.createSound( Assets.WoogaGroupSound );
			
			/* Voiceover - Announcer */
			_sounds[ Sounds.ANNOUNCER_KENDA ] = Assets.createSound( Assets.AnnouncerKendaSound );
			_sounds[ Sounds.ANNOUNCER_RAYU ] = Assets.createSound( Assets.AnnouncerRayuSound );
			
			_sounds[ Sounds.ANNOUNCER_VERSUS ] = Assets.createSound( Assets.AnnouncerVersusSound );
			
			_sounds[ Sounds.ANNOUNCER_ROUND_ONE ] = Assets.createSound( Assets.AnnouncerRoundOneSound );
			_sounds[ Sounds.ANNOUNCER_ROUND_TWO ] = Assets.createSound( Assets.AnnouncerRoundTwoSound );
			_sounds[ Sounds.ANNOUNCER_ROUND_THREE ] = Assets.createSound( Assets.AnnouncerRoundThreeSound );
			_sounds[ Sounds.ANNOUNCER_ROUND_FOUR ] = Assets.createSound( Assets.AnnouncerRoundFourSound );
			_sounds[ Sounds.ANNOUNCER_ROUND_FIVE ] = Assets.createSound( Assets.AnnouncerRoundFiveSound );
			_sounds[ Sounds.ANNOUNCER_FIGHT ] = Assets.createSound( Assets.AnnouncerFightSound );
			
			_sounds[ Sounds.ANNOUNCER_KO ] = Assets.createSound( Assets.AnnouncerKOSound );
			
			_sounds[ Sounds.ANNOUNCER_PLAYER_ONE_WINS ] = Assets.createSound( Assets.AnnouncerPlayerOneWinsSound );
			_sounds[ Sounds.ANNOUNCER_PLAYER_TWO_WINS ] = Assets.createSound( Assets.AnnouncerPlayerTwoWinsSound );
			
			/* Menu */
			_sounds[ Sounds.MENU_OK1 ] = Assets.createSound( Assets.MenuOk1Sound );
			_sounds[ Sounds.MENU_OK2 ] = Assets.createSound( Assets.MenuOk2Sound );
			_sounds[ Sounds.MENU_SELECT ] = Assets.createSound( Assets.MenuSelectSound );
			
			/* Versus screen */
			_sounds[ Sounds.VERSUS_DRAMATIC_DRUM ] = Assets.createSound( Assets.VersusDramaticDrumSound );
			_sounds[ Sounds.VERSUS_BOOM ] = Assets.createSound( Assets.VersusBoomSound );
			_sounds[ Sounds.VERSUS_BOOM ] = Assets.createSound( Assets.VersusBoomSound );
			
			/* Fight */
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
			_sounds[ Sounds.FIGHT_BLOCK ] = Assets.createSound( Assets.FightBlockSound );
			
			/* RaYu */
			_sounds[ Sounds.RAYU_HA ] = Assets.createSound( Assets.RayuHaSound );
			_sounds[ Sounds.RAYU_HU ] = Assets.createSound( Assets.RayuHuSound );
			_sounds[ Sounds.RAYU_JUMP ] = Assets.createSound( Assets.RayuJumpSound );
			_sounds[ Sounds.RAYU_RACCOON_FIRE ] = Assets.createSound( Assets.RayuRaccoonFireSound );
			
			/* KenDa */
			_sounds[ Sounds.KENDA_HA ] = Assets.createSound( Assets.KendaHaSound );
			_sounds[ Sounds.KENDA_HU ] = Assets.createSound( Assets.KendaHuSound );
			_sounds[ Sounds.KENDA_JUMP ] = Assets.createSound( Assets.KendaJumpSound );
			_sounds[ Sounds.KENDA_DIAMOND_DASH ] = Assets.createSound( Assets.KendaDiamondDashSound );
		}
	}
}