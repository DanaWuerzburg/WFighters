package net.wooga.wfighters.controller.gamestate 
{
	import flash.ui.Keyboard;
	import net.wooga.wfighters.fighter.Fighter;
	import net.wooga.wfighters.fighter.ControlConfig;
	import net.wooga.wfighters.GameContainer;
	public class FightIntroGameState extends GameState 
	{		
		private var introTime : Number = 0;
		private var fighterOne : Fighter;
		private var fighterTwo : Fighter;
		private var fairnessCounter : uint = 0;
		
		public function FightIntroGameState( gameContainer : GameContainer )
		{
			super( gameContainer );
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.fightArea.addFighter( fighterOne = new Fighter( gameContainer ) );
			gameContainer.fightArea.addFighter( fighterTwo = new Fighter( gameContainer ) );
			
			var controlConfig : ControlConfig;
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.T;
			controlConfig.downKey =		Keyboard.G;
			controlConfig.leftKey =		Keyboard.F;
			controlConfig.rightKey =	Keyboard.H;
			controlConfig.punchKey =	Keyboard.A;
			controlConfig.kickKey =		Keyboard.S;
			controlConfig.jumpKey =		Keyboard.D;
			fighterOne.controlConfig = controlConfig;
			
			controlConfig = new ControlConfig();
			controlConfig.upKey =		Keyboard.UP;
			controlConfig.downKey =		Keyboard.DOWN;
			controlConfig.leftKey =		Keyboard.LEFT;
			controlConfig.rightKey =	Keyboard.RIGHT;
			controlConfig.punchKey =	Keyboard.J;
			controlConfig.kickKey =		Keyboard.K;
			controlConfig.jumpKey =		Keyboard.L;
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
			fairnessCounter++;
			fairnessCounter % 2 == 0 ? fighterOne.update( t ) : fighterTwo.update( t );
			fairnessCounter % 2 == 0 ? fighterTwo.update( t ) : fighterOne.update( t );
		}
	}
}