package net.wooga.wfighters.controller.gamestate 
{
	import flash.ui.Keyboard;
	import net.wooga.wfighters.controller.InputController;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.fighter.Fighter;
	import net.wooga.wfighters.fighter.Panda;
	import net.wooga.wfighters.fighter.Racoon;
	import net.wooga.wfighters.gui.HPGauge;
	
	public class ConfigureFightersGameState extends GameState 
	{		
		private var fighterOne : Fighter;
		private var fighterTwo : Fighter;
		private var playerOneFighter : Class;
		private var playerTwoFighter : Class;
		
		public function ConfigureFightersGameState( gameContainer : GameContainer, playerOne : Class, playerTwo : Class )
		{
			super( gameContainer );
			playerOneFighter = playerOne;
			playerTwoFighter = playerTwo;
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.fightArea.visible = true;
			gameContainer.hpGauge.visible = true;
			
			gameContainer.fightArea.reset();
			gameContainer.fightArea.addFighter( fighterOne = new playerOneFighter( gameContainer, 0 ) );
			gameContainer.fightArea.addFighter( fighterTwo = new playerTwoFighter( gameContainer, 1 ) );
			
			fighterOne.controlConfig = InputController.CONTROL_CONFIG_1;
			fighterOne.x = FightArea.FIGHTER_ONE_START_X;
			
			fighterTwo.controlConfig = InputController.CONTROL_CONFIG_2;
			fighterTwo.x = FightArea.FIGHTER_TWO_START_X;
			
			fighterOne.opponent = fighterTwo;
			fighterTwo.opponent = fighterOne;
			
			gameContainer.gameController.changeGameState( new BeginRoundGameState( gameContainer ) );
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{

		}
	}
}