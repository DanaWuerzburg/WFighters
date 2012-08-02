package net.wooga.wfighters.fightarea 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import net.wooga.wfighters.fighter.Fighter;
	import net.wooga.wfighters.gui.FightHUD;

	public class FightArea extends Sprite
	{
		public static const FIGHTER_ONE_START_X : int = 300;
		public static const FIGHTER_TWO_START_X : int = 800;
		
		private var fighterList : Vector.<Fighter> = new Vector.<Fighter>();
		
		private var boundsRect : Rectangle = new Rectangle( 0, 0, 1280, 480 );
		private var cameraRectangle : Rectangle = new Rectangle( 0, 0, 640, 480 );
		
		private var foreground : Foreground;
		private var floor : Floor;
		private var fighterContainer : Sprite;
		
		private var skyBitmapData : BitmapData;
		private var backgroundBitmapData : BitmapData;
		private var renderMatrix : Matrix = new Matrix;
				
		public function FightArea() 
		{
			super();
			
			floor = new Floor();
			addChild( floor );
			
			fighterContainer = new Sprite();
			addChild( fighterContainer );
			
			foreground = new Foreground();
			addChild( foreground );
			
			skyBitmapData = ( new Assets.SkyBitmap() as Bitmap ).bitmapData;
			backgroundBitmapData = ( new Assets.BackgroundBitmap() as Bitmap ).bitmapData;
			updateCamera();
		}
		
		public function reset() : void
		{
			fighterList.length = 0;
		}
		
		public function resetFighters() : void
		{
			for each ( var fighter : Fighter in fighterList )
			{
				fighter.reset();
			}
			fighterList[0].x = FIGHTER_ONE_START_X;
			fighterList[1].x = FIGHTER_TWO_START_X;
			
			for each ( var resetFighter : Fighter in fighterList )
			{
				handleFighterPositionChanged( resetFighter );
			}
		}
		
		public function addFighter( fighter : Fighter ) : void
		{
			fighterList.push( fighter );
			fighter.fightArea = this;
			fighterContainer.addChild( fighter );
		}
		
		public function update( t : int ) : void
		{
			var index : uint = 0;
			var length : uint = fighterList.length;
			for ( index = 0; index < length; index++ )
			{
				fighterList[ index ].update( t );
			}
		}
		
		public function handleFighterPositionChanged( fighter : Fighter ) : void
		{
			if ( fighter.x < boundsRect.x ) fighter.x = boundsRect.x;
			if ( fighter.x + 100 > boundsRect.width ) fighter.x = boundsRect.width - 100;
			
			var index : uint;
			var length : uint = fighterList.length;
			var middleX : Number = 0;
			for ( index = 0; index < length; index++ )
			{
				if ( fighterList[ index ] != fighter )
				{
					if ( fighter.x > fighterList[ index ].x && fighter.x - fighterList[ index ].x > cameraRectangle.width - 100 )
					{
						fighter.x += cameraRectangle.width - 100 - ( fighter.x - fighterList[ index ].x )
					}
					else if ( fighter.x < fighterList[ index ].x && fighterList[ index ].x - fighter.x > cameraRectangle.width - 100 )
					{
						fighter.x -= cameraRectangle.width - 100 - ( fighterList[ index ].x - fighter.x )
					}
				}
			}
			for ( index = 0; index < length; index++ )
			{
				middleX += fighterList[ index ].x + 50;
			}
			middleX /= fighterList.length;
			cameraRectangle.x = Math.round( Math.max( boundsRect.left, Math.min( boundsRect.right - cameraRectangle.width, middleX - cameraRectangle.width / 2 ) ) );
			updateCamera();	
			
		}
		
		public function updateCamera() : void
		{
			x = -cameraRectangle.x;

			graphics.clear();
			
			renderMatrix.tx = cameraRectangle.x - 60 * cameraRectangle.x / 640;
			renderMatrix.ty = 0;
			graphics.beginBitmapFill( skyBitmapData , renderMatrix );
			graphics.drawRect( renderMatrix.tx, 0, skyBitmapData.width, skyBitmapData.height ); 
			graphics.endFill();
			
			renderMatrix.tx = cameraRectangle.x / 2;
			renderMatrix.ty = 0;
			graphics.beginBitmapFill( backgroundBitmapData , renderMatrix );
			graphics.drawRect( cameraRectangle.x, 0, 640, 480 ); 
			graphics.endFill();
			
			foreground.x = cameraRectangle.x - ( 1480 - 640 ) * cameraRectangle.x / 640;
			
			floor.x = cameraRectangle.x;
			floor.update( cameraRectangle.x / 1280 );
		}
	}
}