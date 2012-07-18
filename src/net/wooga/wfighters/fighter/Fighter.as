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
	import net.wooga.wfighters.spriteset.FrameConfig;
	import net.wooga.wfighters.spriteset.Spriteset;
	
	public class Fighter extends Sprite 
	{
		private static const STATE_STAND : String = "STATE_STAND";
		private static const STATE_JUMP : String = "STATE_JUMP";
		private static const STATE_PUNCH : String = "STATE_PUNCH";
		private static const STATE_KICK : String = "STATE_KICK";
		private static const STATE_JUMP_PUNCH : String = "STATE_JUMP_PUNCH";
		private static const STATE_JUMP_KICK : String = "STATE_JUMP_KICK";
		private static const STATE_BLOCK : String = "STATE_BLOCK";
		private static const STATE_DAMAGE : String = "STATE_DAMAGE";
		private static const STATE_DOWN : String = "STATE_DOWN";
		private static const STATE_KO : String = "STATE_KO";
		
		private static const MAX_DAMAGE : Number = 100;
		
		private var _state : String;
		private var gameContainer : GameContainer;
		private var _controlConfig : ControlConfig;
		private var _fightArea : FightArea;
		private var _opponent : Fighter;
		private var _damage : Number = 0;
		
		private var jumpTime : Number = 0;
		private var jumpVector : Vector3D = new Vector3D();
		
		private var punchTime : Number = 0;
		private var punchKeyReleased : Boolean = false;
		
		private var kickTime : Number = 0;
		private var kickKeyReleased : Boolean = false;
		
		private var jumpPunchTime : Number = 0;
		
		private var jumpKickTime : Number = 0;
		
		private var blockTime : Number = 0;
		private var blockDamage : Number = 0;
		
		private var damageTime : Number = 0;
		private var damageLevel : Number = 0;
		
		private var downTime : Number = 0;
		private var downVector : Vector3D = new Vector3D();
		
		private var spriteset : Spriteset;
		
		public function Fighter( gameContainer : GameContainer ) 
		{
			super();
			this.gameContainer = gameContainer;
			state = STATE_STAND;
			
			spriteset = new Spriteset( new <FrameConfig>
			[
				new FrameConfig( "idle",		new Assets.IdleBitmap() ),
				new FrameConfig( "punch",		new Assets.PunchBitmap(), new Vector3D( -25, 0 ) ),
				new FrameConfig( "kick",		new Assets.KickBitmap(), new Vector3D( -50, 5 ) ),
				new FrameConfig( "jumppunch",	new Assets.JumpPunchBitmap() ),
				new FrameConfig( "jumpkick",	new Assets.JumpKickBitmap() ),
				new FrameConfig( "jump",		new Assets.JumpBitmap() ),
				new FrameConfig( "block",		new Assets.BlockBitmap() ),
				new FrameConfig( "damage",		new Assets.DamageBitmap() ),
				new FrameConfig( "down",		new Assets.DownBitmap() ),
			] );
			addChild( spriteset );
		}
		
		public function update( t : int ) : void
		{
			switch ( state )
			{
				case STATE_STAND:		updateStand( t );	break;
				case STATE_JUMP:		updateJump( t );	break;
				case STATE_PUNCH:		updatePunch( t );	break;
				case STATE_KICK:		updateKick( t );	break;
				case STATE_JUMP_PUNCH:	updateJumpPunch( t );	break;
				case STATE_JUMP_KICK:	updateJumpKick( t );	break;
				case STATE_BLOCK:		updateBlock( t );	break;
				case STATE_DAMAGE:		updateDamage( t );	break;
				case STATE_DOWN:		updateDown( t );	break;
			}
			updateCollision();
			if ( state != STATE_DOWN )
			{
				updateDirection();
			}
			
			if ( !gameContainer.inputController.isKeyPressed( _controlConfig.punchKey ) )
			{
				punchKeyReleased = true;
			}
			if ( !gameContainer.inputController.isKeyPressed( _controlConfig.kickKey ) )
			{
				kickKeyReleased = true;
			}
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
		
		public function receivePunch() : void
		{
			receiveDamage();
		}
		
		public function receiveKick() : void
		{
			receiveDamage();
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
				case STATE_JUMP:		handleEnterJump(); break;
				case STATE_PUNCH:		handleEnterPunch(); break;
				case STATE_KICK:		handleEnterKick(); break;
				case STATE_JUMP_PUNCH:	handleEnterJumpPunch(); break;
				case STATE_JUMP_KICK:	handleEnterJumpKick(); break;
				case STATE_BLOCK:		handleEnterBlock(); break;
				case STATE_DAMAGE:		handleEnterDamage(); break;
				case STATE_DOWN: 		handleEnterDown(); break;
			}
		}
		
		private function updateStand( t : int ) : void
		{
			spriteset.showFrame( "idle" );
			
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
				x -= 0.3 * t;
				_fightArea.handleFighterPositionChanged( this );
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.rightKey ) )
			{
				x += 0.3 * t;
				_fightArea.handleFighterPositionChanged( this );
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.upKey ) )
			{
				state = STATE_JUMP;
			}
			if ( punchKeyReleased && gameContainer.inputController.isKeyPressed( _controlConfig.punchKey ) )
			{
				state = STATE_PUNCH;
			}
			if ( kickKeyReleased && gameContainer.inputController.isKeyPressed( _controlConfig.kickKey ) )
			{
				state = STATE_KICK;
			}
		}
		
		private function handleEnterJump() : void
		{
			jumpTime = 0;
			jumpVector.x = 0;
			jumpVector.y = -2;
			spriteset.showFrame( "jump" );
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
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.punchKey ) && jumpVector.y > 0 )
			{
				state = STATE_JUMP_PUNCH;
			}
			if ( gameContainer.inputController.isKeyPressed( _controlConfig.kickKey ) && jumpVector.y > 0 )
			{
				state = STATE_JUMP_KICK;
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
			parent.setChildIndex( this, parent.numChildren - 1 );
			spriteset.showFrame( "punch" );
			punchKeyReleased = false;
			if ( _opponent && Math.abs( x - _opponent.x ) < width + 10 )
			{
				_opponent.receivePunch();
			}
		}
		
		private function updatePunch( t : int ) : void
		{
			punchTime += t;
			if ( punchTime > 100 )
			{
				state = STATE_STAND;
			}
		}
		
		private function handleEnterKick() : void
		{
			kickTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			spriteset.showFrame( "kick" );
			kickKeyReleased = false;
			if ( _opponent && Math.abs( x - _opponent.x ) < width + 10 )
			{
				_opponent.receiveKick();
			}
		}
		
		private function updateKick( t : int ) : void
		{
			kickTime += t;
			if ( kickTime > 100 )
			{
				state = STATE_STAND;
			}
		}
		
		private function handleEnterJumpPunch() : void
		{
			jumpPunchTime = 0;
			spriteset.showFrame( "jumppunch" );
			punchKeyReleased = false;
		}
		
		private function updateJumpPunch( t : int ) : void
		{
			updateJump( t );
		}
		
		private function handleEnterJumpKick() : void
		{
			jumpKickTime = 0;
			spriteset.showFrame( "jumpkick" );
			kickKeyReleased = false;
		}
		
		private function updateJumpKick( t : int ) : void
		{
			updateJump( t );
		}
		
		private function handleEnterBlock() : void
		{
			blockTime = 0;
			blockDamage = 0;
			spriteset.showFrame( "block" );
		}
		
		private function updateBlock( t : int ) : void
		{
			blockTime += t;
			if ( blockTime > 250 )
			{
				state = STATE_STAND;
			}
		}
		
		private function handleEnterDamage() : void
		{
			damageTime = 0;
			damageLevel = 0;
			spriteset.showFrame( "damage" );
		}
		
		private function updateDamage( t : int ) : void
		{
			damageTime += t;
			if ( damageTime > 250 )
			{
				state = STATE_STAND;
			}
		}
		
		private function handleEnterDown() : void
		{
			downTime = 0;
			downVector.x = ( x - _opponent.x );
			downVector.y = -100;
			downVector.z = 0;
			downVector.normalize();
			spriteset.showFrame( "down" );
		}
		
		private function updateDown( t : int ) : void
		{
			if ( downTime == 0 )
			{
				x += downVector.x * t / 2;
				y += downVector.y * t / 2;
				
				downVector.y += t / 300;
				_fightArea.handleFighterPositionChanged( this );
			}
			if ( y >= 200 )
			{
				y = 200;
				downTime += t;
			}
			if ( downTime > 500 )
			{
				state = STATE_STAND;
			}
		}
		
		private function updateCollision() : void
		{
			if ( _opponent && hitTestObject( _opponent ) )
			{
				if ( x > _opponent.x && x - _opponent.x < 100)
				{
					x += 100 - ( x - _opponent.x );
					_fightArea.handleFighterPositionChanged( this );
				}
				else if ( x < _opponent.x && _opponent.x - x < 100 )
				{
					x -= 100 - ( _opponent.x - x )
					_fightArea.handleFighterPositionChanged( this );
				}
				else if ( x == _opponent.x )
				{
					x += 10;
					_opponent.x -= 10;
					_fightArea.handleFighterPositionChanged( this );
					_fightArea.handleFighterPositionChanged( _opponent );
				}
			}
		}
		
		private function updateDirection() : void
		{
			if ( _opponent )
			{
				if ( x < _opponent.x )
				{
					spriteset.scaleX = -1;
					spriteset.x = 100;
				}
				else
				{
					spriteset.scaleX = 1;
					spriteset.x = 0;
				}
			}
		}
		
		private function receiveDamage() : void
		{
			switch ( state )
			{
				case STATE_STAND:
				{
					if ( gameContainer.inputController.isKeyPressed( _controlConfig.leftKey ) && _opponent.x > x )
					{
						state = STATE_BLOCK;
					}
					else if ( gameContainer.inputController.isKeyPressed( _controlConfig.rightKey ) && _opponent.x < x )
					{
						state = STATE_BLOCK;
					}
					else
					{
						state = STATE_DAMAGE;
					}
					break;
				}
				case STATE_PUNCH:
				{
					state = STATE_DAMAGE;
					break;
				}
				case STATE_KICK:
				{
					state = STATE_DAMAGE;
					break;
				}
				case STATE_BLOCK:
				{
					blockTime = 0;
					blockDamage++;
					if ( blockDamage > 3 )
					{
						state = STATE_DAMAGE;
					}
					break;
				}
				case STATE_DAMAGE:
				{
					damageTime = 0;
					damageLevel++;
					if ( damageLevel > 5 )
					{
						state = STATE_DOWN;
					}
					break;
				}
			}
		}
	}
}