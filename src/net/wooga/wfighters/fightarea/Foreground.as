package net.wooga.wfighters.fightarea 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	public class Foreground extends Sprite 
	{
		
		private var foregroundBitmapData : BitmapData;
		private var renderMatrix : Matrix = new Matrix;
		
		public function Foreground() 
		{
			super();
			foregroundBitmapData = ( new Assets.ForegroundBitmap() as Bitmap ).bitmapData;
			
			renderMatrix.ty = 380;
			graphics.beginBitmapFill( foregroundBitmapData, renderMatrix );
			graphics.drawRect( 0, renderMatrix.ty, 1480, foregroundBitmapData.height );
			graphics.endFill();
			
			
		}
	}

}