package net.wooga.wfighters.fightarea 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Floor extends Sprite 
	{
		private var floorBitmapData : BitmapData;
		
		private var fp1 : Point = new Point( -640, 380 );
		private var fp2 : Point = new Point( 640, 380 );
		private var fp3 : Point = new Point( 640, 480 );
		private var fp4 : Point = new Point( - 640, 480 );
		private var ft1 : Number = 0.5;
		private var ft2 : Number = 0.5;
		private var ft3 : Number = 1.5;
		private var ft4 : Number = 1.5;	
		
		public function Floor() 
		{
			super();
			floorBitmapData = ( new Assets.FloorBitmap() as Bitmap ).bitmapData;
		}
		
		public function update( xValue : Number = 0 ) : void
		{
			graphics.clear();
			graphics.beginBitmapFill( floorBitmapData );
			graphics.drawTriangles(
				Vector.<Number>([ 320 + fp1.x * ft1, fp1.y, 320 + fp2.x * ft2, fp2.y, 320 + fp3.x * ft3, fp3.y, 320 + fp4.x * ft4, fp4.y ]),
				Vector.<int>([ 0,1,2, 0,2,3 ]),
				Vector.<Number>([ xValue,0,ft1, xValue + 1,0,ft2, xValue + 1,1,ft3, xValue,1,ft4 ]));
			graphics.endFill();
		}
	}
}