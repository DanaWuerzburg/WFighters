package net.wooga.wfighters.controller 
{
	import flash.display.Stage;
	import flash.utils.getTimer;
	import net.wooga.wfighters.controller.gamestate.FightIntroGameState;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.GameContainer;
	
	public class GameController 
	{
		private var state : GameState;
		private var gameContainer : GameContainer;
		private var hasLastFrameTime : Boolean = false;
		private var lastFrameTime : int;
		private var currentTime : int;
		
		public function GameController( gameContainer : GameContainer ) 
		{
			this.gameContainer = gameContainer;
			
			this.changeGameState( new FightIntroGameState( gameContainer ) );
		}
		
		public function update() : void
		{
			currentTime = getTimer();
			if ( this.state ) this.state.update( hasLastFrameTime ? currentTime - lastFrameTime : 0 );
			lastFrameTime = currentTime;
			hasLastFrameTime = true;
		}
		
		private function changeGameState( state : GameState ) : void
		{
			if ( this.state ) this.state.handleResignActive();
			this.state = state;
			this.state.handleBecomeActive();
		}
	}

}