package net.wooga.wfighters.controller.gamestate 
{
	import flash.ui.Keyboard;
	import net.wooga.wfighters.fighter.Fighter;
	import net.wooga.wfighters.fighter.ControlConfig;
	import net.wooga.wfighters.fighter.Panda;
	import net.wooga.wfighters.fighter.Racoon;
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.gui.HPGauge;
	public class FightIntroGameState extends GameState 
	{		
		private var introTime : Number = 0;
		private var fighterOne : Fighter;
		private var fighterTwo : Fighter;
		
		public function FightIntroGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.fightArea.visible = true;
			gameContainer.hpGauge.visible = true;
			
			gameContainer.fightArea.reset();
			gameContainer.fightArea.addFighter( fighterOne = new Racoon( gameContainer, 0 ) );
			gameContainer.fightArea.addFighter( fighterTwo = new Racoon( gameContainer, 1 ) );
			
			var controlConfig : ControlConfig;
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.NUMPAD_8;
			controlConfig.downKey =		Keyboard.NUMPAD_2;
			controlConfig.leftKey =		Keyboard.NUMPAD_4;
			controlConfig.rightKey =	Keyboard.NUMPAD_6;
			controlConfig.punchKey =	Keyboard.C;
			controlConfig.kickKey =		Keyboard.NUMBER_5;
			fighterOne.controlConfig = controlConfig;
			fighterOne.x = 300;
			
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.R;
			controlConfig.downKey =		Keyboard.F;
			controlConfig.leftKey =		Keyboard.D;
			controlConfig.rightKey =	Keyboard.G;
			controlConfig.punchKey =	Keyboard.RIGHTBRACKET;
			controlConfig.kickKey =		Keyboard.NUMBER_6;
			fighterTwo.controlConfig = controlConfig;
			fighterTwo.x = 800;
			
			fighterOne.opponent = fighterTwo;
			fighterTwo.opponent = fighterOne;
		}
		
		public override function handleResignActive() : void
		{
			
		}
		
		public override function update( t : int ) : void
		{
			introTime += t;
			gameContainer.fightArea.update( t );
		}
	}
}