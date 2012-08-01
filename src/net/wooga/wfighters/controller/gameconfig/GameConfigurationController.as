package net.wooga.wfighters.controller.gameconfig
{
	public class GameConfigurationController
	{
		private var _roundsPerMatch : uint;
		
		private const DEFAULT_ROUNDS_PER_MATCH : uint = 2;
		
		public function GameConfigurationController()
		{
			_roundsPerMatch = DEFAULT_ROUNDS_PER_MATCH;
		}
		
		public function get roundsPerMatch() : uint
		{
			return _roundsPerMatch;
		}
	}
}