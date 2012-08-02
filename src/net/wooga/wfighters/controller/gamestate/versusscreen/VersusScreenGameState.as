package net.wooga.wfighters.controller.gamestate.versusscreen 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import net.wooga.wfighters.controller.gamestate.characterselect.CharacterSet;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.gamestate.vsmatch.ConfigureFightersGameState;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.events.PlaySoundEvent;
	import net.wooga.wfighters.GameContainer;
	
	public class VersusScreenGameState extends GameState 
	{
		private var sunContainer : Sprite;
		private var sun : Bitmap;
		private var fire : Bitmap;
		private var vs : Bitmap;
		private var player1Bitmap : Bitmap;
		private var player2Bitmap : Bitmap;
		private var player1 : CharacterSet;
		private var player2 : CharacterSet;
		private var player1Text : TextField;
		private var player2Text : TextField;
		private var soundStep : int = 0;
		
		private var time : Number;
		
		public function VersusScreenGameState( gameContainer:GameContainer, player1 : CharacterSet, player2 : CharacterSet ) 
		{
			super(gameContainer);
			this.player1 = player1;
			this.player2 = player2;
			sun = new Assets.VersusScreenSunBitmap();
			vs = new Assets.VersusScreenVSBitmap();
			fire = new Assets.VersusScreenFireBitmap();
			
			sunContainer = new Sprite();
			sunContainer.addChild( sun );
			sun.x = -sun.width / 2;
			sun.y = -sun.height / 2;
			sunContainer.x = 320;
			sunContainer.y = 180;
			
			vs.x = 320 - vs.width / 2;
			vs.y = 180 - vs.height / 2;
			
			player1Bitmap = new player1.bigPreviewClass();
			player1Bitmap.x = -100;
			player1Bitmap.y = -50;
			player1Bitmap.scaleX = 1.5;
			player1Bitmap.scaleY = 1.5;
			player1Bitmap.rotation = 10;
			
			player2Bitmap = new player2.bigPreviewClass();
			player2Bitmap.x = 740;
			player2Bitmap.y = -50;
			player2Bitmap.scaleX = -1.5;
			player2Bitmap.scaleY = 1.5;
			player2Bitmap.rotation = -10;
			
			
			player1Text = gameContainer.createBigTextField();
			player1Text.text = player1.name;
			player1Text.x = 40;
			player1Text.y = 40;
			player1Text.textColor = 0x000000;
			player2Text = gameContainer.createBigTextField();
			player2Text.text = player2.name;
			player2Text.x = 600 - player2Text.width;
			player2Text.y = 40;
			player2Text.textColor = 0x000000;
			
			var outline:GlowFilter=new GlowFilter(0xFFFFFF,1.0,5,5,10); 
			outline.quality = BitmapFilterQuality.MEDIUM;
			player1Text.filters = [ outline ];
			player2Text.filters = [ outline ];
			
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( sunContainer );
			gameContainer.addChild( fire );
			gameContainer.addChild( player1Bitmap );
			gameContainer.addChild( player2Bitmap );
			gameContainer.addChild( vs );
			gameContainer.addChild( player1Text );
			gameContainer.addChild( player2Text );
			
			sunContainer.visible = false;
			fire.visible = false;
			player1Bitmap.visible = false;
			player2Bitmap.visible = false;
			player1Text.visible = player2Text.visible = false;
			vs.visible = false;
			
			time = 0;
			soundStep = 0;
			
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( sunContainer );
			gameContainer.removeChild( fire );
			gameContainer.removeChild( vs );
			gameContainer.removeChild( player1Bitmap );
			gameContainer.removeChild( player2Bitmap );
			gameContainer.removeChild( player1Text );
			gameContainer.removeChild( player2Text );
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			sunContainer.rotation = time / 10;
			
			player1Bitmap.visible = true;
			player1Bitmap.x = Math.min( -100, -1000 + ( time / 200 ) * 900 );
			
			player2Bitmap.visible = true;
			player2Bitmap.x = Math.max( 740, 2640 - ( time / 200 ) * 900 );
			
			if ( soundStep == 0 && time > 100 )
			{
				gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.VERSUS_DRAMATIC_DRUM ) );
				soundStep++;
			}
			else if ( soundStep == 1 && time > 300 )
			{
				gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.VERSUS_DRAMATIC_DRUM ) );
				soundStep++;
			}
			else if ( soundStep == 2 && time > 1300 )
			{
				gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.VERSUS_BOOM ) );
				soundStep++;
			}
			
			if ( time > 1300 && time < 3000 )
			{
				sunContainer.visible = true;
				fire.visible = true;
				player1Text.visible = true;
				player2Text.visible = true;
				player1Text.alpha = player2Text.alpha = sunContainer.alpha = fire.alpha = Math.min( 1, ( time - 1300 ) / 200 );
				vs.visible = true;
				vs.alpha = Math.min( 1, ( time - 1300 ) / 200 );
				vs.scaleX = 2 - vs.alpha;
				vs.scaleY = 2 - vs.alpha;
				vs.x = 320 - vs.width / 2;
				vs.y = 180 - vs.height / 2;
			}
			else if ( time > 5000 && time < 6000 )
			{
				player1Text.alpha = player2Text.alpha = player2Bitmap.alpha = player1Bitmap.alpha = sunContainer.alpha = fire.alpha = vs.alpha = 1 - Math.min( 1, ( time - 5000 ) / 200 );
				vs.scaleX = 4 - vs.alpha * 3;
				vs.scaleY = 4 - vs.alpha * 3;
				vs.x = 320 - vs.width / 2;
				vs.y = 180 - vs.height / 2;
			}
			else if ( time > 6000 )
			{
				gameContainer.gameController.changeGameState(
					new ConfigureFightersGameState(
						gameContainer,
						player1.characterClass,
						player2.characterClass
						)
					);
			}
		}
	}
}