package net.wooga.wfighters.fightarea 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import net.wooga.wfighters.fighter.Fighter;
	public class FightArea extends Sprite
	{
		
		private var fighterList : Vector.<Fighter> = new Vector.<Fighter>();
		
		private var boundsRect : Rectangle = new Rectangle( 0, 0, 1280, 480 );
		private var cameraRectangle : Rectangle = new Rectangle( 0, 0, 640, 480 );
		
		private var index : uint;
		private var length : uint;
		private var floorLoader : Loader;
		private var floorBitmapData : BitmapData;
		private var fp1 : Point = new Point();
		private var fp2 : Point = new Point();
		private var fp3 : Point = new Point();
		private var fp4 : Point = new Point();
		private var ft1 : Number;
		private var ft2 : Number;
		private var ft3 : Number;
		private var ft4 : Number;		
		
		public function FightArea() 
		{
			super();
			floorBitmapData = ( new Assets.FloorBitmap() as Bitmap ).bitmapData;
			updateCamera();
		}
		
		public function addFighter( fighter : Fighter ) : void
		{
			fighterList.push( fighter );
			fighter.fightArea = this;
			addChild( fighter );
		}
		
		public function handleFighterPositionChanged( fighter : Fighter ) : void
		{
			if ( fighter.x < boundsRect.x ) fighter.x = boundsRect.x;
			if ( fighter.x + 100 > boundsRect.width ) fighter.x = boundsRect.width - 100;
			
			length = fighterList.length;
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
			
			fp1.x = boundsRect.left + cameraRectangle.x;
			fp1.y = 300;
			fp2.x = boundsRect.right + cameraRectangle.x;
			fp2.y = 300;
			fp3.x = boundsRect.right - 320;
			fp3.y = boundsRect.bottom;
			fp4.x = boundsRect.left - 320;
			fp4.y = boundsRect.bottom;
			
			ft1 = 1 / (1 + 0.5);
			ft2 = 1 / (1 + 0.5);
			ft3 = 1 / (1 - 0.5);
			ft4 = 1 / (1 - 0.5);
			
			graphics.clear();
			graphics.beginBitmapFill( floorBitmapData );
			graphics.drawTriangles(
				Vector.<Number>([ fp1.x * ft1, fp1.y, fp2.x * ft2, fp2.y, fp3.x * ft3, fp3.y, fp4.x * ft4, fp4.y ]),
				Vector.<int>([ 0,1,2, 0,2,3 ]),
				Vector.<Number>([ 0,0,ft1, 1,0,ft2, 1,1,ft3, 0,1,ft4 ]));
			graphics.endFill();
			
		}		
	}
}