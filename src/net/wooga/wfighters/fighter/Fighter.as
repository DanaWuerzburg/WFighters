package net.wooga.wfighters.fighter 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import net.wooga.wfighters.controller.gamestate.KOGameState;
	import net.wooga.wfighters.fightarea.FightArea;
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.spriteset.FrameConfig;
	import net.wooga.wfighters.spriteset.Spriteset;
	
	public class Fighter extends Sprite 
	{
		private static const STATE_FREE : String = "STATE_FREE";
		private static const STATE_COMBO : String = "STATE_COMBO";
		private static const STATE_JUMP : String = "STATE_JUMP";
		private static const STATE_JUMP_ATTACK : String = "STATE_JUMP_ATTACK";
		private static const STATE_BLOCK : String = "STATE_BLOCK";
		private static const STATE_DAMAGE : String = "STATE_DAMAGE";
		private static const STATE_DOWN : String = "STATE_DOWN";
		private static const STATE_KO : String = "STATE_KO";
		
		private static const MAX_DAMAGE : Number = 100;
		private static const MAX_DAMAGE_LEVEL : Number = 4000;
		private static const MOVE_SPEED : Number = 0.4;
		private static const JUMP_SPEED : Number = 0.03;
		private static const DAMAGE_TIME : Number = 500;
		private static const BLOCK_TIME : Number = 300;
		
		private var _id : uint;
		private var _state : String;
		private var gameContainer : GameContainer;
		private var _controlConfig : ControlConfig;
		private var _fightArea : FightArea;
		private var _opponent : Fighter;
		private var _damage : Number = 0;
		private var _comboHelper : ComboHelper;
		private var triggeredKeys : Dictionary = new Dictionary();
		private var hitPoint : Point = new Point();
		private var globalHitTestPoint : Point;
		private var isWalking : Boolean = false;
		private var walkTime : Number = 0;
		
		private var comboTime : Number = 0;
		
		private var jumpTime : Number = 0;
		private var jumpVector : Vector3D = new Vector3D();
		
		private var jumpAttackOffset : Vector3D = new Vector3D();
		private var jumpAttackSuccess : Boolean = false;
		
		private var punchTime : Number = 0;
		private var punchKeyReleased : Boolean = false;
		
		private var kickTime : Number = 0;
		private var kickKeyReleased : Boolean = false;
		
		private var jumpPunchTime : Number = 0;
		
		private var jumpKickTime : Number = 0;
		
		private var blockTime : Number = 0;
		private var blockDamage : Number = 0;
		private var blockDisabledTime : Number = 0;
		
		private var damageTime : Number = 0;
		private var damageLevel : Number = 0;
		
		private var downTime : Number = 0;
		private var downVector : Vector3D = new Vector3D();
		
		private var koVector : Vector3D = new Vector3D();
		
		private var spriteset : Spriteset;
		
		public function Fighter( gameContainer : GameContainer, id : uint ) 
		{
			super();
			_id = id;
			this.gameContainer = gameContainer;
			
			addChild( spriteset = createSpriteset() );
			
			var base : Combo = buildBaseCombo();
			base.canFail = true;
			var combo : Combo;
			
			base.addCombo( Combo.FORWARD, combo = buildBaseCombo( forward ) )
			{
				combo.canFail = true;
				combo.addCombo( Combo.FORWARD, combo = buildBaseCombo( forward ) )
				{
					combo.canFail = true;
					combo.addCombo( Combo.PUNCH, combo = new Combo( special ) );
					{
						combo.canFail = true;
					}
				}
			}
			
			_comboHelper = new ComboHelper( base );
			
			state = STATE_FREE;
			damage = 0;
		}
		
		override public function hitTestPoint( hitX : Number, hitY : Number, shapeFlag:Boolean = false ) : Boolean 
		{
			hitPoint.x = x;
			hitPoint.y = y;
			globalHitTestPoint = localToGlobal( hitPoint );
			return (
				hitX > globalHitTestPoint.x && hitX < globalHitTestPoint.x + 100 &&
				hitY > globalHitTestPoint.x && hitY < globalHitTestPoint.y + 100
				)
		}
		
		private function buildBaseCombo( callback : Function = null ) : Combo
		{
			var base : Combo = new Combo( callback );
			var combo : Combo;
			
			base.addCombo( Combo.PUNCH, combo = new Combo( punch ) );
			{
				combo.addCombo( Combo.PUNCH, combo = new Combo( punchPunch ) );
				{
					combo.addCombo( Combo.PUNCH, combo = new Combo( punchPunchPunch ) );
				}
			}
			base.addCombo( Combo.KICK, combo = new Combo( kick ) );
			{
				combo.addCombo( Combo.KICK, combo = new Combo( kickKick ) );
				{
					combo.addCombo( Combo.KICK, combo = new Combo( kickKickKick ) );
				}
			}
			base.addCombo( Combo.JUMP, combo = new Combo( jump ) );
			{
				combo
					.addCombo( Combo.PUNCH, combo = new Combo( jumpPunch ) )
					.addCombo( Combo.KICK, combo = new Combo( jumpKick ) );
			}
			
			return base;
		}
		
		protected function createSpriteset() : Spriteset
		{
			return new Spriteset( new <FrameConfig>[] );
		}
		
		private function forward() : void
		{
			comboTime = 300;
		}
		
		private function punch() : void
		{
			state = STATE_COMBO;
			comboTime = 400;
			spriteset.showFrame( "punch0" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function punchPunch() : void
		{
			state = STATE_COMBO;
			comboTime = 400;
			spriteset.showFrame( "punch1" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function punchPunchPunch() : void
		{
			state = STATE_COMBO;
			comboTime = 800;
			spriteset.showFrame( "punch2" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kick() : void
		{
			state = STATE_COMBO;
			comboTime = 400;
			spriteset.showFrame( "kick0" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kickKick() : void
		{
			state = STATE_COMBO;
			comboTime = 400;
			spriteset.showFrame( "kick1" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kickKickKick() : void
		{
			state = STATE_COMBO;
			comboTime = 400;
			spriteset.showFrame( "kick2" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 - 100 * spriteset.scaleX;
			hitPoint.y = 50;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function jump() : void
		{
			state = STATE_JUMP;
			comboTime = 200;
			spriteset.showFrame( "jump" );
			jumpVector.y = -100;
		}
		
		private function jumpPunch() : void
		{
			state = STATE_JUMP_ATTACK;
			comboTime = 200;
			spriteset.showFrame( "jumppunch" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			jumpAttackOffset.x = width / 2 - 55 * spriteset.scaleX;
			jumpAttackOffset.y = 50;
			jumpAttackSuccess = false;
		}
		
		private function jumpKick() : void
		{
			state = STATE_JUMP_ATTACK;
			comboTime = 200;
			spriteset.showFrame( "jumpkick" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			jumpAttackOffset.x = width / 2 - 55 * spriteset.scaleX;
			jumpAttackOffset.y = 100;
			jumpAttackSuccess = false;
		}
		
		private function special() : void
		{
			trace( "special" );
		}
		
		private function endCombo() : void
		{
			_comboHelper.reset();
		}
		
		private function isKeyPressed( key : uint ) : Boolean
		{
			return gameContainer.inputController.isKeyPressed( key );
		}
		
		private function isKeyTriggered( key : uint ) : Boolean
		{
			var wasPressed : Boolean = triggeredKeys[ key ];
			triggeredKeys[ key ] = isKeyPressed( key );
			return !wasPressed && triggeredKeys[ key ];
		}
		
		public function update( t : int ) : void
		{						
			switch ( state )
			{
				case STATE_FREE:
				{
					if ( comboTime > 0 )
					{
						comboTime -= t;
						if ( comboTime <= 0 )
						{
							endCombo();
						}
					}
					if ( isKeyPressed( _controlConfig.leftKey ) )
					{
						x -= t * MOVE_SPEED;
						_fightArea.handleFighterPositionChanged( this );
						if ( !isWalking )
						{
							isWalking = true;
							walkTime = 0;
						}
					}
					else if ( isKeyPressed( _controlConfig.rightKey ) )
					{
						x += t * MOVE_SPEED;
						_fightArea.handleFighterPositionChanged( this );
						if ( !isWalking )
						{
							isWalking = true;
							walkTime = 0;
						}
					}
					else
					{
						isWalking = false;
					}
					
					if ( isWalking )
					{
						spriteset.showFrame("walk01");
					}
					else
					{
						spriteset.showFrame("stand01");
					}
					
					if ( isKeyTriggered( _controlConfig.leftKey ) )
					{
						if ( spriteset.scaleX > 0 )
						{
							_comboHelper.trigger( Combo.FORWARD );
						}
						else
						{
							_comboHelper.trigger( Combo.BACK );
						}
					}
					if ( isKeyTriggered( _controlConfig.rightKey ) )
					{
						if ( spriteset.scaleX < 0 )
						{
							_comboHelper.trigger( Combo.FORWARD );
						}
						else
						{
							_comboHelper.trigger( Combo.BACK );
						}
					}
					if ( isKeyTriggered( _controlConfig.punchKey ) )
					{
						_comboHelper.trigger( Combo.PUNCH );
					}
					if ( isKeyTriggered( _controlConfig.kickKey ) )
					{
						_comboHelper.trigger( Combo.KICK );
					}
					if ( isKeyTriggered( _controlConfig.upKey ) )
					{
						_comboHelper.trigger( Combo.JUMP );
					}
					updateDirection();
					break;
				}
				case STATE_COMBO:
				{
					if ( comboTime > 0 )
					{
						comboTime -= t;
						if ( comboTime <= 0 )
						{
							endCombo();
							state = STATE_FREE;
						}
					}
					if ( isKeyTriggered( _controlConfig.punchKey ) )
					{
						_comboHelper.trigger( Combo.PUNCH );
					}
					if ( isKeyTriggered( _controlConfig.kickKey ) )
					{
						_comboHelper.trigger( Combo.KICK );
					}
					break;
				}
				case STATE_JUMP:
				{
					if ( isKeyPressed( _controlConfig.leftKey ) )
					{
						x -= t * MOVE_SPEED;
					}
					else if ( isKeyPressed( _controlConfig.rightKey ) )
					{
						x += t * MOVE_SPEED;
					}
					jumpVector.y += t / 4.5;
					y += jumpVector.y * t * JUMP_SPEED;
					_fightArea.handleFighterPositionChanged( this );
					if ( y > lowestY )
					{
						y = lowestY;
						state = STATE_FREE;
						endCombo();
					}
					else
					{
						if ( isKeyTriggered( _controlConfig.punchKey ) )
						{
							_comboHelper.trigger( Combo.PUNCH );
						}
						if ( isKeyTriggered( _controlConfig.kickKey ) )
						{
							_comboHelper.trigger( Combo.KICK );
						}
					}
					break;
				}
				case STATE_JUMP_ATTACK:
				{
					if ( isKeyPressed( _controlConfig.leftKey ) )
					{
						x -= t * MOVE_SPEED;
					}
					else if ( isKeyPressed( _controlConfig.rightKey ) )
					{
						x += t * MOVE_SPEED;
					}
					jumpVector.y += t / 4.5;
					y += jumpVector.y * t * JUMP_SPEED;
					_fightArea.handleFighterPositionChanged( this );
					
					if ( !jumpAttackSuccess )
					{
						hitPoint.x = jumpAttackOffset.x;
						hitPoint.y = jumpAttackOffset.y;
						globalHitTestPoint = localToGlobal( hitPoint );
						if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
						{
							jumpAttackSuccess = true;
							_opponent.receiveDamage();
						}
					}
					
					if ( y > lowestY )
					{
						y = lowestY;
						state = STATE_FREE;
						endCombo();
					}
					break;
				}
				case STATE_BLOCK:
				{					
					blockTime -= t;
					if ( blockTime <= 0 )
					{
						state = STATE_FREE;
					}
					break;
				}
				case STATE_DAMAGE:
				{
					damageTime -= t;
					if ( damageTime <= 0 )
					{
						state = STATE_FREE;
					}
					break;
				}
				case STATE_DOWN:
				{
					if ( y < lowestY || downVector.y < 0 )
					{
						downVector.y += t / 4.5;
						y += downVector.y * t * JUMP_SPEED;
						x += downVector.x * t * JUMP_SPEED;
						_fightArea.handleFighterPositionChanged( this );
					}
					if ( downTime > 0 )
					{
						downTime -= t;
						if ( downTime <= 0 )
						{
							state = STATE_FREE;
						}
					}
					else if ( y >= lowestY )
					{
						spriteset.showFrame( "ko" );
						downTime = 1000;
					}
					break;
				}
				case STATE_KO:
				{
					if ( y < lowestY || koVector.y < 0 )
					{
						koVector.y += t / 4.5;
						y += koVector.y * t * JUMP_SPEED;
						x += koVector.x * t * JUMP_SPEED;
						_fightArea.handleFighterPositionChanged( this );
					}
					if ( y >= lowestY )
					{
						spriteset.showFrame( "ko" );
					}
					break;
				}
			}
			
			if ( y < lowestY )
			{
				y += t;
				if ( y > lowestY )
				{
					y = lowestY;
				}
				_fightArea.handleFighterPositionChanged( this );
			}
			else if ( y > lowestY )
			{
				y = lowestY;
			}
			
			if ( blockDamage > 0 )
			{
				blockDamage -= t / 100;
				if ( blockDamage < 0 )
				{
					blockDamage = 0;
				}
			}
			
			if ( damageLevel > 0 )
			{
				damageLevel -= t;
				if ( damageLevel < 0 )
				{
					damageLevel = 0;
				}
			}
			
			if ( blockDisabledTime > 0 )
			{
				blockDisabledTime -= t;
			}
			
			
			updateCollision();
			
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
		
		private function get lowestY() : Number
		{
			return 430 - height;
		}
		
		private function handleStateChanged() : void
		{
			if ( state != STATE_COMBO )
			{
				endCombo();
			}
			
			switch ( state )
			{
				case STATE_BLOCK:
				{
					blockTime = BLOCK_TIME;
					spriteset.showFrame( "block" );
					break;
				}
				case STATE_DAMAGE:
				{
					damageTime = DAMAGE_TIME;
					spriteset.showFrame( "damage" );
					damageLevel += 1000;
					if ( damageLevel > MAX_DAMAGE_LEVEL )
					{
						damageLevel = 0;
						state = STATE_DOWN;
					}
					break;
				}
				case STATE_DOWN:
				{
					spriteset.showFrame( "down" );
					downVector.x = _opponent.x > x ? -20 : 20;
					downVector.y = -70;
					downTime = 0;
					break;
				}
				case STATE_KO:
				{
					spriteset.showFrame( "down" );
					koVector.x = _opponent.x > x ? -20 : 20;
					koVector.y = -70;
					gameContainer.gameController.changeGameState( new KOGameState( gameContainer ) );
					break;
				}
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
					spriteset.scaleX = 1;
					spriteset.x = 0;
				}
				else
				{
					spriteset.scaleX = -1;
					spriteset.x = 100;
				}
			}
		}
		
		private function receiveDamage( damage : Number = 10 ) : void
		{
			switch ( state )
			{
				case STATE_FREE:
				{
					if
					(
						blockDisabledTime <= 0 &&
						(
							isKeyPressed( _controlConfig.leftKey ) && _opponent.x > x ||
							isKeyPressed( _controlConfig.rightKey ) && _opponent.x < x
						)
					)
					{
						state = STATE_BLOCK;
						blockDamage += damage;
						if ( blockDamage > 50 )
						{
							blockDamage = 0;
							blockDisabledTime = 10000;
							state = STATE_DAMAGE;
						}
						else
						{
							damage = Math.max( 0, damage - 9 );
						}
					}
					else
					{
						state = STATE_DAMAGE;
					}
					break;
				}
				case STATE_COMBO:
				case STATE_JUMP:
				case STATE_JUMP_ATTACK:
				case STATE_DAMAGE:
				{
					state = STATE_DAMAGE;
					break;
				}
				case STATE_BLOCK:
				{
					state = STATE_BLOCK;
					blockDamage += damage;
					if ( blockDamage > 50 )
					{
						blockDamage = 0;
						blockDisabledTime = 10000;
						state = STATE_DAMAGE;
					}
					else
					{
						damage = Math.max( 0, damage - 9 );
					}
					break;
				}
				case STATE_DOWN:
				{
					damage = 0;
					break;
				}
				case STATE_KO:
				{
					return;
				}
			}
			this.damage += damage;
		}
		
		private function set damage( damage : Number ) : void
		{
			_damage = damage;
			if ( damage >= MAX_DAMAGE )
			{
				state = STATE_KO;
			}
			gameContainer.hpGauge.setHp( _id, ( MAX_DAMAGE - damage ) / MAX_DAMAGE );
		}
		
		private function get damage() : Number
		{
			return _damage;
		}
	}
}