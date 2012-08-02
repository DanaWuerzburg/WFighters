package net.wooga.wfighters.controller.player 
{
	import flash.events.IEventDispatcher;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.events.FighterWonRoundEvent;
	
	public class PlayerStatsController 
	{
		private const NUM_PLAYERS : uint = 2;
		
		private var playerData : Vector.<PlayerData>;
		private var eventDispatcher : IEventDispatcher;
		
		public function PlayerStatsController( eventDispatcher : IEventDispatcher ) 
		{
			this.eventDispatcher = eventDispatcher;
			init();
		}
		
		public function reset() : void
		{
			eventDispatcher.removeEventListener( FighterWonRoundEvent.TYPE_NAME, onRoundWon );
			init();
		}
		
		public function getRoundsWon( playerId : uint ) : uint
		{
			return playerData[ playerId ].roundsWon;
		}
		
		private function init() : void
		{
			playerData = new Vector.<PlayerData>( NUM_PLAYERS );
			
			for( var i : uint = 0; i < NUM_PLAYERS; ++i )
				playerData[i] = new PlayerData();
			
			eventDispatcher.addEventListener( FighterWonRoundEvent.TYPE_NAME, onRoundWon );
		}
		
		private function onRoundWon( event : FighterWonRoundEvent ) : void
		{
			playerData[ event.playerId ].roundsWon += 1;
		}
	}
}