package net.wooga.wfighters.controller.gamestate 
{
	import flash.ui.Keyboard;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.fighter.ControlConfig;
	import net.wooga.wfighters.fighter.Fighter;
	import net.wooga.wfighters.fighter.Panda;
	import net.wooga.wfighters.fighter.Racoon;
	import net.wooga.wfighters.gui.HPGauge;
	
	public class ConfigureFightersGameState extends GameState 
	{		
		private var fighterOne : Fighter;
		private var fighterTwo : Fighter;
		
		public function ConfigureFightersGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.fightArea.visible = true;
			gameContainer.fightHud.visible = true;
			
			gameContainer.fightArea.reset();
			gameContainer.fightArea.addFighter( fighterOne = new Racoon( gameContainer, 0 ) );
			gameContainer.fightArea.addFighter( fighterTwo = new Panda( gameContainer, 1 ) );
			
			var controlConfig : ControlConfig;
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.NUMPAD_8;
			controlConfig.downKey =		Keyboard.NUMPAD_2;
			controlConfig.leftKey =		Keyboard.NUMPAD_4;
			controlConfig.rightKey =	Keyboard.NUMPAD_6;
			controlConfig.punchKey =	Keyboard.C;
			controlConfig.kickKey =		Keyboard.NUMBER_5;
			fighterOne.controlConfig = controlConfig;
			fighterOne.x = FightArea.FIGHTER_ONE_START_X;
			
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.R;
			controlConfig.downKey =		Keyboard.F;
			controlConfig.leftKey =		Keyboard.D;
			controlConfig.rightKey =	Keyboard.G;
			controlConfig.punchKey =	Keyboard.RIGHTBRACKET;
			controlConfig.kickKey =		Keyboard.NUMBER_6;
			fighterTwo.controlConfig = controlConfig;
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