package net.wooga.wfighters 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	
	public class Fighter extends Sprite 
	{
		private static const STATE_STAND : String = "STATE_STAND";
		private static const STATE_JUMP : String = "STATE_JUMP";
		private static const STATE_PUNCH : String = "STATE_PUNCH";
		
		private var _state : String;
		private var gameContainer : GameContainer;
		
		private var jumpTime : Number = 0;
		private var jumpVector : Vector3D = new Vector3D();
		
		private var punchTime : Number = 0;
		
		public function Fighter( gameContainer : GameContainer ) 
		{
			super();
			this.gameContainer = gameContainer;
			state = STATE_STAND;
			
			graphics.beginFill( 0xFF0000 );
			graphics.drawRect( 0, 0, 100, 100 );
			graphics.endFill();
		}
		
		public function update( t : int ) : void
		{
			switch ( state )
			{
				case STATE_STAND:	updateStand( t );	break;
				case STATE_JUMP:	updateJump( t );	break;
				case STATE_PUNCH:	updatePunch( t );	break;
			}
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
			if ( y < 400 )
			{
				y += t;
			}
			if ( y > 400 )
			{
				y = 400;
			}
			if ( gameContainer.inputController.isKeyPressed( 37 ) )
			{
				x -= 0.5 * t;
			}
			if ( gameContainer.inputController.isKeyPressed( 39 ) )
			{
				x += 0.5 * t;
			}
			if ( gameContainer.inputController.isKeyPressed( 38 ) )
			{
				state = STATE_JUMP;
			}
			if ( gameContainer.inputController.isKeyPressed( 65 ) )
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
			if ( gameContainer.inputController.isKeyPressed( 37 ) )
			{
				jumpVector.x -= 0.1 * moveFactor;
				if ( jumpVector.x < -0.5 ) jumpVector.x = -0.5;
			}
			if ( gameContainer.inputController.isKeyPressed( 39 ) )
			{
				jumpVector.x += 0.1 * moveFactor;
				if ( jumpVector.x > 0.5 ) jumpVector.x = 0.5;
			}
			
			y += jumpVector.y * t;
			x += jumpVector.x * t;
			
			jumpVector.y += 0.01 * t;
			
			if ( y >= 400 )
			{
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
	}
}