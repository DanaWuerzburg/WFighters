package net.wooga.wfighters.gui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class HPGauge extends Sprite 
	{
		private var bitmapData : BitmapData;
		private var _hp1 : Number = 0.75;
		private var _hp2 : Number = 0.25;
		
		public function HPGauge() 
		{
			bitmapData = ( new Assets.HPBitmap as Bitmap ).bitmapData;
			update();
		}
		
		public function setHp( id : uint, percent : Number ) : void
		{
			id == 0 ? hp1 = percent : hp2 = percent;
		}
		
		public function set hp1( percent : Number ) : void
		{
			_hp1 = Math.max( 0, Math.min( 1, percent ) );
			update();
		}
		
		public function set hp2( percent : Number ) : void
		{
			_hp2 = Math.max( 0, Math.min( 1, percent ) );
			update();
		}
		
		private function update() : void
		{
			graphics.clear();
			
			graphics.beginFill( 0xFF0000 );
			graphics.drawRect( 13, 27, 303, 21 );
			graphics.drawRect( 324, 27, 303, 21 );
			graphics.endFill();
			
			graphics.beginFill( 0xFFFF00 );
			graphics.drawRect( 316 - 303 * _hp1, 27, 303 * _hp1, 21 );
			graphics.drawRect( 324, 27, 303 * _hp2, 21 );
			graphics.endFill();
			
			graphics.beginBitmapFill( bitmapData );
			graphics.drawRect( 0, 0, bitmapData.width, bitmapData.height );
			graphics.endFill();
		}
	}

}