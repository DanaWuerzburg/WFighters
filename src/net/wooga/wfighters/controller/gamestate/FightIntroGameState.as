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
			
			gameContainer.fightArea.addFighter( fighterOne = new Racoon( gameContainer, 0 ) );
			gameContainer.fightArea.addFighter( fighterTwo = new Racoon( gameContainer, 1 ) );
			
			var controlConfig : ControlConfig;
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.W;
			controlConfig.downKey =		Keyboard.S;
			controlConfig.leftKey =		Keyboard.A;
			controlConfig.rightKey =	Keyboard.D;
			controlConfig.punchKey =	Keyboard.F;
			controlConfig.kickKey =		Keyboard.G;
			fighterOne.controlConfig = controlConfig;
			
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.UP;
			controlConfig.downKey =		Keyboard.DOWN;
			controlConfig.leftKey =		Keyboard.LEFT;
			controlConfig.rightKey =	Keyboard.RIGHT;
			controlConfig.punchKey =	Keyboard.J;
			controlConfig.kickKey =		Keyboard.K;
			fighterTwo.controlConfig = controlConfig;
			fighterTwo.x = 200;
			
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