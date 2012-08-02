package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import net.wooga.wfighters.math.GameMath;
	
	public class HealthGauge extends Sprite
	{	
		private const BASE_OFFSET_FROM_FRAME_CORNER : Number = 2;
		
		private var lifebarFrame : Bitmap;
		private var lifebarBase : Bitmap;
		private var lifebarFill : Bitmap;
		
		private var _fillDirection : HealthGaugeFillDirection;
		
		public function HealthGauge( fillDirection : HealthGaugeFillDirection )
		{
			super();
			
			_fillDirection = fillDirection;
			
			init();
		}
		
		public function set percentHealth( value : Number ) : void
		{
			value = GameMath.clamp( value, 0, 1 );
			lifebarFill.width = lifebarBase.width * (1 - value);
			
			switch( _fillDirection )
			{
				case HealthGaugeFillDirection.SHRINK_LEFT:
					lifebarFill.x = lifebarBase.x + lifebarBase.width - lifebarFill.width;
					break;
				case HealthGaugeFillDirection.SHRINK_RIGHT:
					lifebarFill.x = lifebarBase.x;
					break;
				default:
					trace("ERROR: Unknown health gauge fill direction.");
					break;
			}
				
			
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
			
			lifebarFill.x = lifebarBase.x;
			lifebarFill.y = lifebarBase.y;
			lifebarFill.height = lifebarBase.height;
			percentHealth = 1.0;
			
			addChild( lifebarBase );
			addChild( lifebarFill );
			addChild( lifebarFrame );
		}
	}
}