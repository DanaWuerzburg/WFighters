package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.media.Sound;

	public class Assets 
	{
		public static function createBitmap( bitmapClass : Class ) : Bitmap
		{
			return new bitmapClass() as Bitmap;
		}
		
		public static function createSound( soundClass : Class ) : Sound
		{
			return new soundClass() as Sound;
		}
		
		// TODO: test
		public static function generateSpriteFromBitmap( bitmapClass : Class ) : Sprite
		{
			var bitmapData : BitmapData = (new bitmapClass() as Bitmap).bitmapData;
			var graphic : Sprite = new Sprite();
			graphic.graphics.beginBitmapFill( bitmapData );
			graphic.graphics.drawRect( 0, 0, bitmapData.width, bitmapData.height );
			graphic.graphics.endFill();
			return graphic;
		}
		
		/* Voiceover */
		[Embed(source="sound/voiceover/woogafighter.mp3")]
		public static const WoogaFighterSound : Class;
		[Embed(source="sound/voiceover/woogagroup.mp3")]
		public static const WoogaGroupSound : Class;
		
		/* Voiceover - Announcer */
		[Embed(source="sound/voiceover/announcer/announcer_kenda.mp3")]
		public static const AnnouncerKendaSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_rayu.mp3")]
		public static const AnnouncerRayuSound : Class;
		
		[Embed(source="sound/voiceover/announcer/announcer_versus.mp3")]
		public static const AnnouncerVersusSound : Class;
		
		[Embed(source="sound/voiceover/announcer/announcer_roundone.mp3")]
		public static const AnnouncerRoundOneSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_roundtwo.mp3")]
		public static const AnnouncerRoundTwoSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_roundthree.mp3")]
		public static const AnnouncerRoundThreeSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_roundfour.mp3")]
		public static const AnnouncerRoundFourSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_roundfive.mp3")]
		public static const AnnouncerRoundFiveSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_fight.mp3")]
		public static const AnnouncerFightSound : Class;
		
		[Embed(source="sound/voiceover/announcer/announcer_ko.mp3")]
		public static const AnnouncerKOSound : Class;
		
		[Embed(source="sound/voiceover/announcer/announcer_playeronewins.mp3")]
		public static const AnnouncerPlayerOneWinsSound : Class;
		[Embed(source="sound/voiceover/announcer/announcer_playertwowins.mp3")]
		public static const AnnouncerPlayerTwoWinsSound : Class;
		
		
		/* SFX */
		[Embed(source = "sound/sfx/menu_ok.mp3")]
		public static const MenuOk1Sound : Class;
		[Embed(source = "sound/sfx/menu_ok2.mp3")]
		public static const MenuOk2Sound : Class;
		[Embed(source = "sound/sfx/menu_select.mp3")]
		public static const MenuSelectSound : Class;
		[Embed(source = "sound/sfx/dramatic_drum.mp3")]
		public static const VersusDramaticDrumSound : Class;
		[Embed(source = "sound/sfx/boom.mp3")]
		public static const VersusBoomSound : Class;
		[Embed(source = "sound/sfx/punch01.mp3")]
		public static const FightPunch01Sound : Class;
		[Embed(source = "sound/sfx/punch02.mp3")]
		public static const FightPunch02Sound : Class;
		[Embed(source = "sound/sfx/punch03.mp3")]
		public static const FightPunch03Sound : Class;
		[Embed(source = "sound/sfx/punch04.mp3")]
		public static const FightPunch04Sound : Class;
		[Embed(source = "sound/sfx/punch05.mp3")]
		public static const FightPunch05Sound : Class;
		[Embed(source = "sound/sfx/punch06.mp3")]
		public static const FightPunch06Sound : Class;
		[Embed(source = "sound/sfx/punch07.mp3")]
		public static const FightPunch07Sound : Class;
		[Embed(source = "sound/sfx/punch08.mp3")]
		public static const FightPunch08Sound : Class;
		[Embed(source = "sound/sfx/punch09.mp3")]
		public static const FightPunch09Sound : Class;
		[Embed(source = "sound/sfx/ground01.mp3")]
		public static const FightGround01Sound : Class;
		[Embed(source = "sound/sfx/ground02.mp3")]
		public static const FightGround02Sound : Class;
		[Embed(source = "sound/sfx/ground03.mp3")]
		public static const FightGround03Sound : Class;
		[Embed(source = "sound/sfx/block.mp3")]
		public static const FightBlockSound : Class;
		
		/* Fonts */
		[Embed(source = "SF Quartzite Bold.ttf", fontName="Quartzite", embedAsCFF = "false")]
		public static const QuartziteFont : Class;
		[Embed(source = "JOYSTIX.ttf", fontName="Joystix", embedAsCFF = "false")]
		public static const JoystixFont : Class;
		[Embed(source = "grilcb__poprawiony-1.ttf", fontName="grilcb", embedAsCFF = "false")]
		public static const GrilcbFont : Class;
		
		
		/* PLACEHOLDER: top GUI */
		[Embed(source = "hp.png")]
		public static const HPBitmap : Class;
		
		/* Start screen */
		[Embed(source = "startscreen/start-screen.png")]
		public static const StartScreenBitmap : Class;
		
		/* Character select */
		[Embed(source = "characterselect/menu-bg.png")]
		public static const CharacterSelectBackgroundBitmap : Class;
		[Embed(source = "characterselect/frame-1p.png")]
		public static const CharacterSelectFrame1PBitmap : Class;
		[Embed(source = "characterselect/frame-2p.png")]
		public static const CharacterSelectFrame2PBitmap : Class;
		[Embed(source = "characterselect/frame-1p2p.png")]
		public static const CharacterSelectFrame1P2PBitmap : Class;
		[Embed(source = "characterselect/preview-small-1.png")]
		public static const CharacterSelectPreviewSmall01Bitmap : Class;
		[Embed(source = "characterselect/preview-small-2.png")]
		public static const CharacterSelectPreviewSmall02Bitmap : Class;
		[Embed(source = "characterselect/preview-small-3.png")]
		public static const CharacterSelectPreviewSmall03Bitmap : Class;
		[Embed(source = "characterselect/preview-small-4.png")]
		public static const CharacterSelectPreviewSmall04Bitmap : Class;
		[Embed(source = "characterselect/preview-small-5.png")]
		public static const CharacterSelectPreviewSmall05Bitmap : Class;
		[Embed(source = "characterselect/preview-small-6.png")]
		public static const CharacterSelectPreviewSmall06Bitmap : Class;
		[Embed(source = "characterselect/preview-small-7.png")]
		public static const CharacterSelectPreviewSmall07Bitmap : Class;
		[Embed(source = "characterselect/preview-small-8.png")]
		public static const CharacterSelectPreviewSmall08Bitmap : Class;
		[Embed(source = "characterselect/preview-small-9.png")]
		public static const CharacterSelectPreviewSmall09Bitmap : Class;
		[Embed(source = "characterselect/preview-big-1.png")]
		public static const CharacterSelectPreviewBig01Bitmap : Class;
		[Embed(source = "characterselect/preview-big-2.png")]
		public static const CharacterSelectPreviewBig02Bitmap : Class;
		[Embed(source = "characterselect/preview-big-3.png")]
		public static const CharacterSelectPreviewBig03Bitmap : Class;
		[Embed(source = "characterselect/preview-big-4.png")]
		public static const CharacterSelectPreviewBig04Bitmap : Class;
		[Embed(source = "characterselect/preview-big-5.png")]
		public static const CharacterSelectPreviewBig05Bitmap : Class;
		[Embed(source = "characterselect/preview-big-6.png")]
		public static const CharacterSelectPreviewBig06Bitmap : Class;
		[Embed(source = "characterselect/preview-big-7.png")]
		public static const CharacterSelectPreviewBig07Bitmap : Class;
		[Embed(source = "characterselect/preview-big-8.png")]
		public static const CharacterSelectPreviewBig08Bitmap : Class;
		[Embed(source = "characterselect/preview-big-9.png")]
		public static const CharacterSelectPreviewBig09Bitmap : Class;
		[Embed(source = "characterselect/1P.png")]
		public static const CharacterSelect1PBitmap : Class;
		[Embed(source = "characterselect/2P.png")]
		public static const CharacterSelect2PBitmap : Class;
		
		/* Versus screen */
		[Embed(source = "versusscreen/KO-sunray.png")]
		public static const VersusScreenSunBitmap : Class;
		[Embed(source = "versusscreen/VS.png")]
		public static const VersusScreenVSBitmap : Class;
		[Embed(source = "versusscreen/VS-fire-particle.png")]
		public static const VersusScreenFireBitmap : Class;
		
		/* Game Screen */
		[Embed(source = "gamescreen/fight.png")]
		public static const FightBitmap : Class;
		[Embed(source = "gamescreen/KO-center.png")]
		public static const KOCenterBitmap : Class;
		[Embed(source = "gamescreen/lifebar-base.png")]
		public static const LifebarBaseBitmap : Class;
		[Embed(source = "gamescreen/lifebar-fill.png")]
		public static const LifebarFillBitmap : Class;
		[Embed(source = "gamescreen/lifebar-frame.png")]
		public static const LifebarFrameBitmap : Class;
		[Embed(source = "gamescreen/round1.png")]
		public static const RoundOneBitmap : Class;
		[Embed(source = "gamescreen/round2.png")]
		public static const RoundTwoBitmap : Class;
		[Embed(source = "gamescreen/round3.png")]
		public static const RoundThreeBitmap : Class;
		[Embed(source = "gamescreen/star.png")]
		public static const RoundsWonIconBitmap : Class;
		
		/* Environment */
		[Embed(source = "floor.png")]
		public static const FloorBitmap : Class;
		[Embed(source = "sky.png")]
		public static const SkyBitmap : Class;
		[Embed(source = "foreground.png")]
		public static const ForegroundBitmap : Class;
		[Embed(source = "background.png")]
		public static const BackgroundBitmap : Class;
		
		/* Panda */
		[Embed(source = "panda/pandaBlock.png")]
		public static const PandaBlockBitmap : Class;
		[Embed(source = "panda/pandaFireball01.png")]
		public static const PandaFireball01Bitmap : Class;
		[Embed(source = "panda/pandaFireball02.png")]
		public static const PandaFireball02Bitmap : Class;
		[Embed(source = "panda/pandaHit01.png")]
		public static const PandaHit01Bitmap : Class;
		[Embed(source = "panda/pandaHit02.png")]
		public static const PandaHit02Bitmap : Class;
		[Embed(source = "panda/pandaJump01.png")]
		public static const PandaJump01Bitmap : Class;
		[Embed(source = "panda/pandaJump02.png")]
		public static const PandaJump02Bitmap : Class;
		[Embed(source = "panda/pandaJump03.png")]
		public static const PandaJump03Bitmap : Class;
		[Embed(source = "panda/pandaJump04.png")]
		public static const PandaJump04Bitmap : Class;
		[Embed(source = "panda/pandaJump05.png")]
		public static const PandaJump05Bitmap : Class;
		[Embed(source = "panda/pandaJump06.png")]
		public static const PandaJump06Bitmap : Class;
		[Embed(source = "panda/pandaJump07.png")]
		public static const PandaJump07Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack01.png")]
		public static const PandaJumpBack01Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack02.png")]
		public static const PandaJumpBack02Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack03.png")]
		public static const PandaJumpBack03Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack04.png")]
		public static const PandaJumpBack04Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack05.png")]
		public static const PandaJumpBack05Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack06.png")]
		public static const PandaJumpBack07Bitmap : Class;
		[Embed(source = "panda/pandaJumpBack07.png")]
		public static const PandaJumpBack06Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward01.png")]
		public static const PandaJumpFoward01Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward02.png")]
		public static const PandaJumpFoward02Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward03.png")]
		public static const PandaJumpFoward03Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward04.png")]
		public static const PandaJumpFoward04Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward05.png")]
		public static const PandaJumpFoward05Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward06.png")]
		public static const PandaJumpFoward06Bitmap : Class;
		[Embed(source = "panda/pandaJumpFoward07.png")]
		public static const PandaJumpFoward07Bitmap : Class;
		[Embed(source = "panda/pandaJumpKick01.png")]
		public static const PandaJumpKick01Bitmap : Class;
		[Embed(source = "panda/pandaJumpPunch01.png")]
		public static const PandaJumpPunch01Bitmap : Class;
		[Embed(source = "panda/pandaKick01.png")]
		public static const PandaKick01Bitmap : Class;
		[Embed(source = "panda/pandaKick02.png")]
		public static const PandaKick02Bitmap : Class;
		[Embed(source = "panda/pandaKo01.png")]
		public static const PandaKo01Bitmap : Class;
		[Embed(source = "panda/pandaKo02.png")]
		public static const PandaKo02Bitmap : Class;
		[Embed(source = "panda/pandaKo03.png")]
		public static const PandaKo03Bitmap : Class;
		[Embed(source = "panda/pandaKo04.png")]
		public static const PandaKo04Bitmap : Class;
		[Embed(source = "panda/pandaPunch01.png")]
		public static const PandaPunch01Bitmap : Class;
		[Embed(source = "panda/pandaPunch02.png")]
		public static const PandaPunch02Bitmap : Class;
		[Embed(source = "panda/pandaPunch03.png")]
		public static const PandaPunch03Bitmap : Class;
		[Embed(source = "panda/pandaStand01.png")]
		public static const PandaStand01Bitmap : Class;
		[Embed(source = "panda/pandaStand02.png")]
		public static const PandaStand02Bitmap : Class;
		[Embed(source = "panda/pandaWalk01.png")]
		public static const PandaWalk01Bitmap : Class;
		[Embed(source = "panda/pandaWalk02.png")]
		public static const PandaWalk02Bitmap : Class;
		[Embed(source = "panda/pandaWalk03.png")]
		public static const PandaWalk03Bitmap : Class;
		[Embed(source = "panda/pandaWalk04.png")]
		public static const PandaWalk04Bitmap : Class;
		
		/* Raccoon */
		[Embed(source = "raccoon/raccoonBlock.png")]
		public static const RacoonBlockBitmap : Class;
		[Embed(source = "raccoon/raccoonFireball01.png")]
		public static const RacoonFireball01Bitmap : Class;
		[Embed(source = "raccoon/raccoonFireball02.png")]
		public static const RacoonFireball02Bitmap : Class;
		[Embed(source = "raccoon/raccoonHit01.png")]
		public static const RacoonHit01Bitmap : Class;
		[Embed(source = "raccoon/raccoonHit02.png")]
		public static const RacoonHit02Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump01.png")]
		public static const RacoonJump01Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump02.png")]
		public static const RacoonJump02Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump03.png")]
		public static const RacoonJump03Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump04.png")]
		public static const RacoonJump04Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump05.png")]
		public static const RacoonJump05Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump06.png")]
		public static const RacoonJump06Bitmap : Class;
		[Embed(source = "raccoon/raccoonJump07.png")]
		public static const RacoonJump07Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack01.png")]
		public static const RacoonJumpBack01Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack02.png")]
		public static const RacoonJumpBack02Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack03.png")]
		public static const RacoonJumpBack03Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack04.png")]
		public static const RacoonJumpBack04Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack05.png")]
		public static const RacoonJumpBack05Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack06.png")]
		public static const RacoonJumpBack07Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpBack07.png")]
		public static const RacoonJumpBack06Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward01.png")]
		public static const RacoonJumpFoward01Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward02.png")]
		public static const RacoonJumpFoward02Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward03.png")]
		public static const RacoonJumpFoward03Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward04.png")]
		public static const RacoonJumpFoward04Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward05.png")]
		public static const RacoonJumpFoward05Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward06.png")]
		public static const RacoonJumpFoward06Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpFoward07.png")]
		public static const RacoonJumpFoward07Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpKick01.png")]
		public static const RacoonJumpKick01Bitmap : Class;
		[Embed(source = "raccoon/raccoonJumpPunch01.png")]
		public static const RacoonJumpPunch01Bitmap : Class;
		[Embed(source = "raccoon/raccoonKick01.png")]
		public static const RacoonKick01Bitmap : Class;
		[Embed(source = "raccoon/raccoonKick02.png")]
		public static const RacoonKick02Bitmap : Class;
		[Embed(source = "raccoon/raccoonKo01.png")]
		public static const RacoonKo01Bitmap : Class;
		[Embed(source = "raccoon/raccoonKo02.png")]
		public static const RacoonKo02Bitmap : Class;
		[Embed(source = "raccoon/raccoonKo03.png")]
		public static const RacoonKo03Bitmap : Class;
		[Embed(source = "raccoon/raccoonKo04.png")]
		public static const RacoonKo04Bitmap : Class;
		[Embed(source = "raccoon/raccoonPunch01.png")]
		public static const RacoonPunch01Bitmap : Class;
		[Embed(source = "raccoon/raccoonPunch02.png")]
		public static const RacoonPunch02Bitmap : Class;
		[Embed(source = "raccoon/raccoonPunch03.png")]
		public static const RacoonPunch03Bitmap : Class;
		[Embed(source = "raccoon/raccoonStand01.png")]
		public static const RacoonStand01Bitmap : Class;
		[Embed(source = "raccoon/raccoonStand02.png")]
		public static const RacoonStand02Bitmap : Class;
		[Embed(source = "raccoon/raccoonWalk01.png")]
		public static const RacoonWalk01Bitmap : Class;
		[Embed(source = "raccoon/raccoonWalk02.png")]
		public static const RacoonWalk02Bitmap : Class;
		[Embed(source = "raccoon/raccoonWalk03.png")]
		public static const RacoonWalk03Bitmap : Class;
		[Embed(source = "raccoon/raccoonWalk04.png")]
		public static const RacoonWalk04Bitmap : Class;
		
		/* Fireball */
		[Embed(source = "fireball/fireball01.png")]
		public static const Fireball01Bitmap : Class;
		[Embed(source = "fireball/fireball02.png")]
		public static const Fireball02Bitmap : Class;
		[Embed(source = "fireball/fireball03.png")]
		public static const Fireball03Bitmap : Class;
		[Embed(source = "fireball/fireball04.png")]
		public static const Fireball04Bitmap : Class;
		[Embed(source = "fireball/fireball05.png")]
		public static const Fireball05Bitmap : Class;
		[Embed(source = "fireball/fireball06.png")]
		public static const Fireball06Bitmap : Class;
	}
}