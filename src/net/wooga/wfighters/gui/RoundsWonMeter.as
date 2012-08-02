package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class RoundsWonMeter extends Sprite
	{
		private var _roundsWon : uint;
		private var _icons : Vector.<Bitmap>;
		private var _growthDirection : RoundsWonMeterGrowthDirection;
		
		public function RoundsWonMeter( growthDirection : RoundsWonMeterGrowthDirection )
		{
			super();
			
			_roundsWon = 0;
			_icons = new Vector.<Bitmap>();
			_growthDirection = growthDirection;
		}
		
		public function get roundsWon() : uint { return _roundsWon; }
		public function set roundsWon( value : uint ) : void
		{ 
			_roundsWon = value;
			updateIcons();
		}
		
		private function updateIcons() : void
		{
			while( _icons.length < _roundsWon )
			{
				var newIcon : Bitmap = Assets.createBitmap( Assets.RoundsWonIconBitmap )
				newIcon.x = _icons.length * newIcon.width;
				
				if( _growthDirection == RoundsWonMeterGrowthDirection.LEFT )
				{
					newIcon.x = -newIcon.x - newIcon.width;
				}
				
				_icons.push( newIcon );
				addChild( newIcon );
			}
		}
	}
}