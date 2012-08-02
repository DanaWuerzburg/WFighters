package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FightHUD extends Sprite
	{
		private var _koCenter : Sprite;
		
		public function FightHUD()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( event : Event = null ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			createKOCenter();
			// Create HP gauges
			// Set up rounds won markers??
		}
		
		private function createKOCenter() : void
		{
			var imageData : BitmapData = (new Assets.KOCenterBitmap() as Bitmap).bitmapData;
			_koCenter = new Sprite();
			_koCenter.graphics.beginBitmapFill( imageData );
			_koCenter.graphics.drawRect( 0, 0, imageData.width, imageData.height );
			_koCenter.graphics.endFill();
			
			_koCenter.x = (stage.stageWidth / 2) - (_koCenter.width / 2);
			_koCenter.y = 40;
			
			addChild( _koCenter );
		}
	}
}