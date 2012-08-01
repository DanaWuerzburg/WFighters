package net.wooga.wfighters.controller.player 
{
	import net.wooga.wfighters.GameContainer;
	
	public class PlayerStatsController 
	{
		private const NUM_PLAYERS : uint = 2;
		
		private var playerData : Vector.<PlayerData>;
		
		public function PlayerStatsController() 
		{
			init();
		}
		
		public function reset() : void
		{
			init();
		}
		
		public function getRoundsWon( playerId : uint ) : uint
		{
			return playerData[ playerId ].roundsWon;
		}
		
		public function setRoundsWon( playerId : uint, roundsWon : uint ) : void
		{
			playerData[ playerId ].roundsWon = roundsWon;
		}
		
		/** Adds one to the number of rounds a player has won. (Convenience function.) */
		public function incrementRoundsWon( playerId : uint ) : void
		{
			var roundsWon : uint = getRoundsWon( playerId ) + 1;
			setRoundsWon( playerId, roundsWon );
		}
		
		private function init() : void
		{
			playerData = new Vector.<PlayerData>( NUM_PLAYERS );
			
			for( var i : uint = 0; i < NUM_PLAYERS; ++i )
				playerData[i] = new PlayerData();
		}
	}
}