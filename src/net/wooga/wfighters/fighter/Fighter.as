package net.wooga.wfighters.fighter 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.GameContainer;
	
	public class Fighter extends Sprite 
	{
		private static const STATE_STAND : String = "STATE_STAND";
		private static const STATE_JUMP : String = "STATE_JUMP";
		private static const STATE_PUNCH : String = "STATE_PUNCH";
		
		private var _state : String;
		private var gameContainer : GameContainer;
		private var _controlConfig : ControlConfig;
		private var _fightArea : FightArea;
		private var _opponent : Fighter;
		
		private var jumpTime : Number = 0;
		private var jumpVector : Vector3D = new Vector3D();
		
		private var punchTime : Number = 0;
		
		private var loader : Loader;
		
		public function Fighter( gameContainer : GameContainer ) 
		{
			super();
			this.gameContainer = gameContainer;
			state = STATE_STAND;
			
			graphics.beginFill( 0xFF0000 );
			graphics.drawRect( 0, 0, 50, 200 );
			graphics.endFill();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, doneLoad );
			loader.load( new URLRequest("res/panda.png") );
		}
		
		private function doneLoad( event : Event ) : void
		{
			addChild( loader );
		}
		
		public function update( t : int ) : void
		{
			switch ( state )
			{
				case STATE_STAND:	updateStand( t );	break;
				case STATE_JUMP:	updateJump( t );	break;
				case STATE_PUNCH:	updatePunch( t );	break;
			}
			updateCollision();
			updateDirection();
		}
		
		public function set controlConfig( controlConfig : ControlConfig ) : void
		{
			_controlConfig = controlConfig;
		}
		
		public function set fightArea( fightArea : FightArea ) : void
		{
			_fightArea = fightArea;
		}
		
		public function set opponent ( fighter : Fighter ) : void
		{
			_opponent = fighter;
		}
		
		private function set state( state : String ) : void
		{
			_state = state;
			handleStateChanged();
		}
		
		private function get state() : String
		{
			return _state;
		}
		
		private function handleStateChanged() : void
		{
			switch ( _state )
			{
				case STATE_STAND: break;
				case STATE_JUMP: handleEnterJump(); break;
				case STATE_PUNCH: handleEnterPunch(); break;
			}
		}
		
		private function updateStand( t : int ) : void
		{
			if ( y < 200 )
			{
				y += t;
			}
			if ( y > 200 )
			{
				y = 200;
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.leftKey ) )
			{
				x -= 0.5 * t;
				_fightArea.handleFighterPositionChanged( this );
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.rightKey ) )
			{
				x += 0.5 * t;
				_fightArea.handleFighterPositionChanged( this );
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.upKey ) )
			{
				state = STATE_JUMP;
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.punchKey ) )
			{
				state = STATE_PUNCH;
			}
		}
		
		private function handleEnterJump() : void
		{
			jumpTime = 0;
			jumpVector.x = 0;
			jumpVector.y = -2;
		}
		
		private function updateJump( t : int ) : void
		{
			jumpTime += t;
			
			var moveFactor : Number = 0;
			if ( jumpTime < 1000 ) moveFactor = 1 - jumpTime / 1000;
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.leftKey ) )
			{
				jumpVector.x -= 0.1 * moveFactor;
				if ( jumpVector.x < -0.5 ) jumpVector.x = -0.5;
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.rightKey ) )
			{
				jumpVector.x += 0.1 * moveFactor;
				if ( jumpVector.x > 0.5 ) jumpVector.x = 0.5;
			}
			
			y += jumpVector.y * t;
			x += jumpVector.x * t;
			_fightArea.handleFighterPositionChanged( this );
			
			jumpVector.y += 0.01 * t;
			
			if ( y >= 200 )
			{
				y = 200;
				state = STATE_STAND;
			}
		}
		
		private function handleEnterPunch() : void
		{
			punchTime = 0;
		}
		
		private function updatePunch( t : int ) : void
		{
			punchTime += t;
			if ( punchTime > 250 )
			{
				state = STATE_STAND;
			}
		}
		
		private function updateCollision() : void
		{
			if ( _opponent && hitTestObject( _opponent ) )
			{
				var intersection : Rectangle = getBounds( this.parent ).intersection( _opponent.getBounds( _opponent.parent ) );
				if ( x < _opponent.x )
				{
					x -= intersection.width;
				}
				else
				{
					x += intersection.width;
				}
			}
		}
		
		private function updateDirection() : void
		{
			if ( _opponent )
			{
				if ( x < _opponent.x )
				{
					loader.scaleX = -1;
				}
				else
				{
					loader.scaleX = 1;
				}
			}
		}
	}
}