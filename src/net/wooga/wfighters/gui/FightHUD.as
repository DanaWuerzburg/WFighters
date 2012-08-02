package net.wooga.wfighters.gui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import net.wooga.wfighters.events.FighterHealthChangedEvent;
	import net.wooga.wfighters.events.FighterWonRoundEvent;
	
	public class FightHUD extends Sprite
	{
		// Positions
		private const KO_CENTER_Y : Number = 28;
		private const GAUGE_Y : Number = KO_CENTER_Y + 5;
		private const GAUGE_OFFSET_X : Number = 3;
		private const ROUND_METER_Y : Number = KO_CENTER_Y - 27;
		
		// Indices
		private const PLAYER_LEFT : uint = 0;
		private const PLAYER_RIGHT : uint = 1;
		
		private var _koCenter : Bitmap;
		private var _healthGauges : Vector.<HealthGauge>;
		private var _roundsWonMeters : Vector.<RoundsWonMeter>;
		
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
			setUpRoundsWonMarkers();
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
			_healthGauges[ PLAYER_LEFT ] = leftGauge;
			_healthGauges[ PLAYER_RIGHT ] = rightGauge;
			
			for each( var gauge : HealthGauge in _healthGauges )
			{
				addChild( gauge );
			}
			
			stage.addEventListener( FighterHealthChangedEvent.TYPE_NAME, onHealthChanged );
		}
		
		private function setUpRoundsWonMarkers() : void
		{
			var leftMeter : RoundsWonMeter = new RoundsWonMeter();
			leftMeter.y = ROUND_METER_Y;
			leftMeter.x = _healthGauges[ PLAYER_LEFT ].x;
			
			var rightMeter : RoundsWonMeter = new RoundsWonMeter();
			rightMeter.y = ROUND_METER_Y;
			rightMeter.x = _healthGauges[ PLAYER_RIGHT ].x;
			
			_roundsWonMeters = new Vector.<RoundsWonMeter>( 2 );
			_roundsWonMeters[ PLAYER_LEFT ] = leftMeter;
			_roundsWonMeters[ PLAYER_RIGHT ] = rightMeter;
			
			for each( var meter : RoundsWonMeter in _roundsWonMeters )
			{
				addChild( meter );
			}
			
			stage.addEventListener( FighterWonRoundEvent.TYPE_NAME, onRoundWon );
		}
		
		private function onHealthChanged( event : FighterHealthChangedEvent ) : void
		{
			_healthGauges[ event.playerId ].percentHealth = event.currentHealthPercent;
		}
		
		private function onRoundWon( event : FighterWonRoundEvent ) : void
		{
			_roundsWonMeters[ event.playerId ].roundsWon += 1;
		}
	}
}