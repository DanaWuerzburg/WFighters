package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.wooga.wfighters.events.FighterHealthChangedEvent;
	
	public class FightHUD extends Sprite
	{
		// Positions
		private const KO_CENTER_Y : Number = 40;
		private const GAUGE_Y : Number = KO_CENTER_Y + 5;
		private const GAUGE_OFFSET_X : Number = 3;
		
		// Indices
		private const HEALTH_GAUGE_LEFT : uint = 0;
		private const HEALTH_GAUGE_RIGHT : uint = 1;
		
		private var _koCenter : Bitmap;
		private var _healthGauges : Vector.<HealthGauge>;
		
		
		public function FightHUD()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( event : Event = null ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			createKOCenter();
			createHealthGauges();
			// Set up rounds won markers??
		}
		
		private function createKOCenter() : void
		{
			_koCenter = Assets.createBitmap( Assets.KOCenterBitmap );
			
			_koCenter.x = (stage.stageWidth / 2) - (_koCenter.width / 2);
			_koCenter.y = KO_CENTER_Y;
			
			addChild( _koCenter );
		}
		
		private function createHealthGauges() : void
		{
			var leftGauge : HealthGauge = new HealthGauge( HealthGaugeFillDirection.SHRINK_RIGHT );
			leftGauge.x = _koCenter.x - leftGauge.width + GAUGE_OFFSET_X;
			leftGauge.y = GAUGE_Y;
			
			var rightGauge : HealthGauge = new HealthGauge( HealthGaugeFillDirection.SHRINK_LEFT );
			rightGauge.x = _koCenter.x + _koCenter.width - GAUGE_OFFSET_X;
			rightGauge.y = GAUGE_Y;
			
			_healthGauges = new Vector.<HealthGauge>( 2 );
			_healthGauges[ HEALTH_GAUGE_LEFT ] = leftGauge;
			_healthGauges[ HEALTH_GAUGE_RIGHT ] = rightGauge;
			
			for each( var gauge : HealthGauge in _healthGauges )
			{
				addChild( gauge );
			}
			
			stage.addEventListener( FighterHealthChangedEvent.TYPE_NAME, onHealthChanged );
		}
		
		private function onHealthChanged( event : FighterHealthChangedEvent ) : void
		{
			_healthGauges[ event.playerId ].percentHealth = event.currentHealthPercent;
		}
	}
}