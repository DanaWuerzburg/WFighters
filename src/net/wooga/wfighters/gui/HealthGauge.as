package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class HealthGauge extends Sprite
	{
		private const BASE_OFFSET_FROM_FRAME_CORNER : Number = 2;
		
		private var lifebarFrame : Bitmap;
		private var lifebarBase : Bitmap;
		private var lifebarFill : Bitmap;
		
		public function HealthGauge()
		{
			super();
			
			init();
		}
		
		private function init() : void
		{
			loadGraphics();
			placeGraphics();
		}
		
		private function loadGraphics() : void
		{
			lifebarFrame = Assets.createBitmap( Assets.LifebarFrameBitmap );
			lifebarBase = Assets.createBitmap( Assets.LifebarBaseBitmap );
			lifebarFill = Assets.createBitmap( Assets.LifebarFillBitmap );
		}
		
		private function placeGraphics() : void
		{
			lifebarFrame.x = lifebarFrame.y = 0;
			
			lifebarBase.x = lifebarFrame.x + BASE_OFFSET_FROM_FRAME_CORNER;
			lifebarBase.y = lifebarFrame.y + BASE_OFFSET_FROM_FRAME_CORNER;
			
			addChild( lifebarBase );
			addChild( lifebarFrame );
		}
	}
}