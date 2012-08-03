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
	
	public class KOGameState extends GameState 
	{
		private const KO_TEXT_CENTER_Y : Number = 150;
		
		private var animationLayer : Sprite;
		private var time : Number = 0;
		private var koText : Bitmap;
		private var koSunray : Bitmap;
		private var koParticles : Bitmap;
		
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
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			koText.x = (gameContainer.stage.stageWidth / 2) - (koText.width / 2);
			koText.y = KO_TEXT_CENTER_Y - (koText.height / 2);
			
			if ( time >= 5000 )
			{
				gameContainer.gameController.changeGameState( new EndOfRoundGameState( gameContainer, koPlayerId ) );
			}
			
			gameContainer.fightArea.update( time < 3000 ? t / 8 : t );
		}
		
		private function loadImages() : void
		{
			koText = Assets.createBitmap( Assets.KOTextBitmap );
			koSunray = Assets.createBitmap( Assets.KOSunrayBitmap );
			koParticles = Assets.createBitmap( Assets.KOParticlesBitmap );
			
			animationLayer = new Sprite();
			animationLayer.addChild( koSunray );
			animationLayer.addChild( koParticles );
			animationLayer.addChild( koText );
		}
	}
}