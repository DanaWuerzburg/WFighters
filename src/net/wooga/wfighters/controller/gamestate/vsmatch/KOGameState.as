package net.wooga.wfighters.controller.gamestate.vsmatch 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.events.PlaySoundEvent;
	import net.wooga.wfighters.gui.GradientEffect;
	import net.wooga.wfighters.math.GameMath;
	
	public class KOGameState extends GameState 
	{
		// Constants
		private const KO_TEXT_CENTER_Y : Number = 150;
		private const KO_TEXT_EFFECT_SCALE : Number = 2;
		private const KO_TEXT_SCALE_TIME : Number = 200;
		
		private const KO_SUNRAY_ROTATION_SPEED : Number = 10;
		private const KO_EFFECT_FADEOUT_START_TIME : int = 2000;
		private const KO_EFFECT_FADEOUT_LENGTH : int = 200;
		
		private const KO_TEXT_FADEOUT_START_TIME : int = KO_EFFECT_FADEOUT_START_TIME + KO_EFFECT_FADEOUT_LENGTH + 500;
		private const KO_TEXT_FADEOUT_LENGTH : int = 200;
		
		private const KO_SCREEN_EXIT_TIME : int = 5000;
		
		// Member variables
		private var animationLayer : Sprite;
		private var time : Number = 0;
		private var koText : Bitmap;
		private var koParticles : Bitmap;
		private var sunrayContainer : Sprite;
		
		private var koPlayerId : uint;
		
		public function KOGameState( gameContainer : GameContainer, koPlayerId : uint )
		{
			super( gameContainer );
			
			this.koPlayerId = koPlayerId;
			
			loadImages();
		}
		
		public override function handleBecomeActive() : void
		{
			trace("Entered KO game state");
			
			gameContainer.fightArea.koLayer.addChild( animationLayer );
			gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.ANNOUNCER_KO ) );
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.fightArea.koLayer.removeChild( animationLayer );
			gameContainer.removeChild( koText );
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			if ( time <= KO_TEXT_SCALE_TIME )
			{
				koText.scaleX = koText.scaleY = GameMath.lerp( KO_TEXT_EFFECT_SCALE, 1, time / KO_TEXT_SCALE_TIME );
				koText.x = (gameContainer.stage.stageWidth / 2) - (koText.width / 2);
				koText.y = KO_TEXT_CENTER_Y - (koText.height / 2);
			}
			
			sunrayContainer.rotation += (t / 1000.0) * KO_SUNRAY_ROTATION_SPEED;
			
			if ( time >= KO_EFFECT_FADEOUT_START_TIME )
			{
				var dtEffectFadeout : Number = time - KO_EFFECT_FADEOUT_START_TIME;				
				animationLayer.alpha = GameMath.lerp( 1, 0, dtEffectFadeout / KO_EFFECT_FADEOUT_LENGTH );
			}
			
			if ( time >= KO_TEXT_FADEOUT_START_TIME )
			{
				var dtTextFadeout : Number = time - KO_TEXT_FADEOUT_START_TIME;
				koText.alpha = GameMath.lerp( 1, 0, dtTextFadeout / KO_EFFECT_FADEOUT_LENGTH );
			}
			
			if ( time >= KO_SCREEN_EXIT_TIME )
			{
				gameContainer.gameController.changeGameState( new EndOfRoundGameState( gameContainer, koPlayerId ) );
			}
			
			gameContainer.fightArea.update( time < 3000 ? t / 8 : t );
		}
		
		private function loadImages() : void
		{
			koText = Assets.createBitmap( Assets.KOTextBitmap );
			koParticles = Assets.createBitmap( Assets.KOParticlesBitmap );
			
			// Load sunray and put inside a sprite container so we can rotate around the center rather than top-left corner
			var koSunray : Bitmap = Assets.createBitmap( Assets.KOSunrayBitmap );
			koSunray.x = -(koSunray.width / 2);
			koSunray.y = -(koSunray.height / 2);
			sunrayContainer = new Sprite();
			sunrayContainer.addChild( koSunray );
			sunrayContainer.x = gameContainer.stage.stageWidth / 2;
			sunrayContainer.y = gameContainer.stage.stageHeight / 2;
			
			animationLayer = new Sprite();
			animationLayer.addChild( sunrayContainer );
			animationLayer.addChild( koParticles );
			
			gameContainer.addChild( koText );
		}
	}
}