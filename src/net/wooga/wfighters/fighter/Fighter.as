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
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.events.PlaySoundEvent;
	
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.controller.gamestate.vsmatch.KOGameState;
	import net.wooga.wfighters.events.FighterHealthChangedEvent;
	import net.wooga.wfighters.events.FighterKOdEvent;
	import net.wooga.wfighters.fightarea.FightArea;
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
		private static const STATE_LOCKED : String = "STATE_LOCKED";
		
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
		private var hitPoint : Point = new Point();
		private var globalHitTestPoint : Point;
		private var isWalking : Boolean = false;
		private var animTime : Number = 0;
		private var animTimeRest : Number = 0;
		
		private var comboTime : Number = 0;
		private var comboLockTime : Number = 0;
		private var comboAnims : Vector.<String> = new Vector.<String>();
		
		private var jumpTime : Number = 0;
		private var jumpVector : Vector3D = new Vector3D();
		private var jumpDir : Number = 0;
		
		private var jumpAttackOffset : Vector3D = new Vector3D();
		private var jumpAttackSuccess : Boolean = false;
				
		private var blockTime : Number = 0;
		private var blockDamage : Number = 0;
		private var blockDisabledTime : Number = 0;
		
		private var damageTime : Number = 0;
		private var damageLevel : Number = 0;
		
		private var downTime : Number = 0;
		private var downVector : Vector3D = new Vector3D();
		
		private var koVector : Vector3D = new Vector3D();
		
		private var spriteset : Spriteset;
		private var bullets : Vector.<Bullet> = new Vector.<Bullet>();
		private var deadBullets : Vector.<Bullet> = new Vector.<Bullet>();
		private var punchSounds : Vector.<String> = new <String>[
			Sounds.FIGHT_PUNCH01,
			Sounds.FIGHT_PUNCH02,
			Sounds.FIGHT_PUNCH03,
			Sounds.FIGHT_PUNCH04,
			Sounds.FIGHT_PUNCH05,
			Sounds.FIGHT_PUNCH06,
			Sounds.FIGHT_PUNCH07,
			Sounds.FIGHT_PUNCH08,
			Sounds.FIGHT_PUNCH09,
			];
		private var groundSounds : Vector.<String> = new <String>[
			Sounds.FIGHT_GROUND01,
			Sounds.FIGHT_GROUND02,
			Sounds.FIGHT_GROUND03
			];
		
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
		
		public function reset() : void
		{
			state = STATE_FREE;
			comboTime = 0;
			comboLockTime = 0;
			y = lowestY;
			isWalking = false;
			endCombo();
			damageTime = 0;
			damageLevel = 0;
			blockTime = 0;
			blockDisabledTime = 0;
			blockDamage = 0;
			damage = 0;
		}
		
		override public function hitTestPoint( hitX : Number, hitY : Number, shapeFlag:Boolean = false ) : Boolean 
		{
			hitPoint.x = -spriteset.currentFrameOffset.x;
			hitPoint.y = spriteset.currentFrameOffset.y;
			globalHitTestPoint = localToGlobal( hitPoint );
			return (
				hitX > globalHitTestPoint.x && hitX < globalHitTestPoint.x + 100 &&
				hitY > globalHitTestPoint.y && hitY < globalHitTestPoint.y + 150
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
		
		protected function createBulletSpriteset() : Spriteset
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
			comboTime = 600;
			comboLockTime = 300;
			comboAnims.length = 0;
			comboAnims.push( "punch01", "punch02", "punch03" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function punchPunch() : void
		{
			state = STATE_COMBO;
			comboTime = 800;
			comboLockTime = 400;
			comboAnims.length = 0;
			comboAnims.push( "punch01", "punch02", "punch03" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function punchPunchPunch() : void
		{
			state = STATE_COMBO;
			comboTime = 1000;
			comboLockTime = 500;
			comboAnims.length = 0;
			comboAnims.push( "punch01", "punch02", "punch03" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kick() : void
		{
			state = STATE_COMBO;
			comboTime = 600;
			comboLockTime = 300;
			comboAnims.length = 0;
			comboAnims.push( "kick01", "kick02" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kickKick() : void
		{
			state = STATE_COMBO;
			comboTime = 800;
			comboLockTime = 400;
			comboAnims.length = 0;
			comboAnims.push( "kick01", "kick02" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
			globalHitTestPoint = localToGlobal( hitPoint );
			if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
			{
				_opponent.receiveDamage();
			}
		}
		
		private function kickKickKick() : void
		{
			state = STATE_COMBO;
			comboTime = 1000;
			comboLockTime = 500;
			comboAnims.length = 0;
			comboAnims.push( "kick01", "kick02" );
			animTime = 0;
			parent.setChildIndex( this, parent.numChildren - 1 );
			hitPoint.x = width / 2 + width / 2 * spriteset.scaleX;
			hitPoint.y = height / 2;
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
			comboLockTime = 200;
			jumpVector.y = -100;
			jumpVector.x = 0;
			jumpTime = 0;
		}
		
		private function jumpPunch() : void
		{
			state = STATE_JUMP_ATTACK;
			comboTime = 200;
			comboLockTime = 200;
			spriteset.showFrame( "jumppunch01" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			jumpAttackOffset.x = width / 2 + width / 2 * spriteset.scaleX;
			jumpAttackOffset.y = height / 2;
			jumpAttackSuccess = false;
		}
		
		private function jumpKick() : void
		{
			state = STATE_JUMP_ATTACK;
			comboTime = 200;
			comboLockTime = 200;
			spriteset.showFrame( "jumpkick01" );
			parent.setChildIndex( this, parent.numChildren - 1 );
			jumpAttackOffset.x = width / 2 + width / 2 * spriteset.scaleX;
			jumpAttackOffset.y = height / 2;
			jumpAttackSuccess = false;
		}
		
		private function special() : void
		{
			state = STATE_COMBO;
			comboTime = 1000;
			comboLockTime = 0;
			comboAnims.length = 0;
			comboAnims.push( "special01", "special02" );
			addBullet();
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
			return gameContainer.inputController.isKeyTriggered( key );
		}
		
		public function update( t : int ) : void
		{						
			updateBullets( t );
			
			animTime += t;
			
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
							animTime = 0;
						}
					}
					else if ( isKeyPressed( _controlConfig.rightKey ) )
					{
						x += t * MOVE_SPEED;
						_fightArea.handleFighterPositionChanged( this );
						if ( !isWalking )
						{
							isWalking = true;
							animTime = 0;
						}
					}
					else if ( isWalking )
					{
						animTime = 0;
						isWalking = false;
					}
					
					if ( isWalking )
					{
						animTimeRest = animTime % 400;
						spriteset.showFrame(
							animTimeRest < 100 ? "walk01" :
							animTimeRest < 200 ? "walk02" :
							animTimeRest < 300 ? "walk03" :
												 "walk04"
							);
					}
					else
					{
						animTimeRest = animTime % 500;
						spriteset.showFrame(
							animTimeRest < 250 ? "stand01" :
												 "stand02"
							);
					}
					
					if ( isKeyTriggered( _controlConfig.leftKey ) )
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
					if ( isKeyTriggered( _controlConfig.rightKey ) )
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
					for ( var index : uint = 0; index < comboAnims.length; index++ )
					{
						if ( animTime < ( index + 1 ) * 100 )
						{
							spriteset.showFrame( comboAnims[ index ] );
							break;
						}
					}
					
					if ( comboTime > 0 )
					{
						comboTime -= t;
						if ( comboTime <= 0 )
						{
							endCombo();
							state = STATE_FREE;
						}
					}
					if ( comboTime < comboLockTime && isKeyTriggered( _controlConfig.punchKey ) )
					{
						_comboHelper.trigger( Combo.PUNCH );
					}
					if ( comboTime < comboLockTime && isKeyTriggered( _controlConfig.kickKey ) )
					{
						_comboHelper.trigger( Combo.KICK );
					}
					break;
				}
				case STATE_JUMP:
				{
					jumpTime += t;
					if ( jumpVector.x == 0 && jumpTime < 100 && isKeyPressed( _controlConfig.leftKey ) )
					{
						jumpVector.x = -0.3;
					}
					else if ( jumpVector.x == 0 && jumpTime < 100 && isKeyPressed( _controlConfig.rightKey ) )
					{
						jumpVector.x = 0.3;
					}
					jumpVector.y += t / 4.5;
					y += jumpVector.y * t * JUMP_SPEED;
					x += jumpVector.x * t;
					
					if ( jumpVector.x == 0 )
					{
						animTimeRest = jumpTime % 1000;
						spriteset.showFrame(
							animTimeRest < 100 ? "jump01" :
							animTimeRest < 200 ? "jump02" :
							animTimeRest < 300 ? "jump03" :
							animTimeRest < 400 ? "jump04" :
							animTimeRest < 500 ? "jump05" :
							animTimeRest < 600 ? "jump06" :
												 "jump07"
							);
					}
					else if ( ( spriteset.scaleX > 0 && jumpVector.x > 0 ) || ( spriteset.scaleX < 0 && jumpVector.x < 0 ) )
					{
						animTimeRest = jumpTime % 1000;
						spriteset.showFrame(
							animTimeRest < 100 ? "jumpForward01" :
							animTimeRest < 200 ? "jumpForward02" :
							animTimeRest < 300 ? "jumpForward03" :
							animTimeRest < 400 ? "jumpForward04" :
							animTimeRest < 500 ? "jumpForward05" :
							animTimeRest < 600 ? "jumpForward06" :
												 "jumpForward07"
							);
					}
					else if ( ( spriteset.scaleX > 0 && jumpVector.x < 0 ) || ( spriteset.scaleX < 0 && jumpVector.x > 0 ) ) 
					{
						animTimeRest = jumpTime % 1000;
						spriteset.showFrame(
							animTimeRest < 100 ? "jumpBack01" :
							animTimeRest < 200 ? "jumpBack02" :
							animTimeRest < 300 ? "jumpBack03" :
							animTimeRest < 400 ? "jumpBack04" :
							animTimeRest < 500 ? "jumpBack05" :
							animTimeRest < 600 ? "jumpBack06" :
												 "jumpBack07"
							);
					}
					
					_fightArea.handleFighterPositionChanged( this );
					if ( y > lowestY )
					{
						y = lowestY;
						gameContainer.stage.dispatchEvent( new PlaySoundEvent( getRandomGroundSound() ) );
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
						gameContainer.stage.dispatchEvent( new PlaySoundEvent( getRandomGroundSound() ) );
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
					if ( damageTime < DAMAGE_TIME - 100 )
					{
						spriteset.showFrame( "hit02" );
					}
					
					if ( damageTime <= 0 )
					{
						state = STATE_FREE;
					}
					break;
				}4
				case STATE_DOWN:
				{
					if ( y < lowestY || downVector.y < 0 )
					{
						spriteset.showFrame( downVector.y > -t ? "ko02" : "ko01" );
						if ( y < lowestY ) downVector.y += t / 4.5;
						y += downVector.y * t * JUMP_SPEED;
						x += downVector.x * t * JUMP_SPEED;
						_fightArea.handleFighterPositionChanged( this );
					}
					if ( downTime > 0 )
					{
						spriteset.showFrame( downTime > 150 ? "ko04" : "ko03" );
						downTime -= t;
						if ( y < lowestY ) downVector.y += t / 4.5;
						y += downVector.y * t * JUMP_SPEED;
						x += downVector.x * t * JUMP_SPEED / 2;
						_fightArea.handleFighterPositionChanged( this );
						if ( y > lowestY )
						{
							downVector.y = 0;
						}
						if ( downTime <= 0 )
						{
							state = STATE_FREE;
						}
					}
					else if ( y >= lowestY )
					{
						spriteset.showFrame( "ko03" );
						downVector.y = -40;
						downTime = 300;
					}
					break;
				}
				case STATE_KO:
				{
					if ( y < lowestY || koVector.y < 0 )
					{
						spriteset.showFrame( koVector.y > -t ? "ko02" : "ko01" );
						koVector.y += t / 4.5;
						y += koVector.y * t * JUMP_SPEED;
						x += koVector.x * t * JUMP_SPEED;
						_fightArea.handleFighterPositionChanged( this );
					}
					if ( downTime > 0 )
					{
						spriteset.showFrame( downTime > 150 ? "ko04" : "ko03" );
						downTime -= t;
						if ( y < lowestY ) koVector.y += t / 4.5;
						y += koVector.y * t * JUMP_SPEED;
						x += koVector.x * t * JUMP_SPEED / 2;
						_fightArea.handleFighterPositionChanged( this );
						if ( y > lowestY )
						{
							koVector.y = 0;
						}
						if ( downTime <= 0 )
						{
							state = STATE_LOCKED;
						}
					}
					else if ( y >= lowestY )
					{
						spriteset.showFrame( "ko03" );
						koVector.y = -40;
						downTime = 300;
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
					trace( 1 );
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( getRandomGroundSound() ) );
				}
				_fightArea.handleFighterPositionChanged( this );
			}
			else if ( y > lowestY )
			{
				y = lowestY;
				gameContainer.stage.dispatchEvent( new PlaySoundEvent( getRandomGroundSound() ) );
				trace( 2 );
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
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.FIGHT_BLOCK ) );
					blockTime = BLOCK_TIME;
					spriteset.showFrame( "block01" );
					break;
				}
				case STATE_DAMAGE:
				{
					gameContainer.stage.dispatchEvent( new PlaySoundEvent( getRandomPunchSound() ) );
					damageTime = DAMAGE_TIME;
					spriteset.showFrame( "hit01" );
					damageLevel += 4000;
					if ( damageLevel > MAX_DAMAGE_LEVEL )
					{
						damageLevel = 0;
						state = STATE_DOWN;
					}
					break;
				}
				case STATE_DOWN:
				{
					spriteset.showFrame( "ko01" );
					downVector.x = _opponent.x > x ? -10 : 10;
					downVector.y = -70;
					downTime = 0;
					break;
				}
				case STATE_KO:
				{
					spriteset.showFrame( "ko01" );
					koVector.x = _opponent.x > x ? -20 : 20;
					koVector.y = -70;
					downTime = 0;
					gameContainer.stage.dispatchEvent( new FighterKOdEvent( _id ) );
					break;
				}
			}
		}
		
		private function updateCollision() : void
		{
			if ( _opponent && Math.abs( y - _opponent.y ) < 100 )
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
			gameContainer.stage.dispatchEvent( new FighterHealthChangedEvent( _id, ( MAX_DAMAGE - damage ) / MAX_DAMAGE ) );
		}
		
		private function get damage() : Number
		{
			return _damage;
		}
		
		private function addBullet() : void
		{
			var bullet : Bullet = new Bullet( createBulletSpriteset() );
			bullet.scaleX = spriteset.scaleX;
			bullet.x = x - width / 2 * spriteset.scaleX + 50;
			bullet.y = y + spriteset.currentFrameOffset.y + 100;
			parent.addChild( bullet );
			bullets.push( bullet );
		}
		
		private function updateBullets( t : uint ) : void
		{
			var index : uint = 0;
			var length : uint = bullets.length;
			var bullet : Bullet;
			for ( index = 0; index < length; index++ )
			{
				bullet = bullets[ index ];
				bullet.update( t );
				bullet.x += t * bullet.scaleX;
				hitPoint.x = bullet.x + ( spriteset.scaleX > 0 ? bullet.width : 0 );
				hitPoint.y = bullet.y + bullet.height / 2;
				globalHitTestPoint = parent.localToGlobal( hitPoint );
				if ( _opponent.hitTestPoint( globalHitTestPoint.x, globalHitTestPoint.y ) )
				{
					_opponent.receiveDamage();
					destroyBullet( bullet );
				}
			}
			
			while ( deadBullets.length )
			{
				bullet = deadBullets.pop();
				parent.removeChild( bullet );
				bullets.splice( bullets.indexOf( bullet ), 1 );
			}
		}
		
		private function destroyBullet ( bullet : Bullet ) : void
		{
			deadBullets.push( bullet );
		}
		
		private function getRandomPunchSound() : String
		{
			return punchSounds[ int( Math.random() * 9 ) ];
		}
		
		private function getRandomGroundSound() : String
		{
			return groundSounds[ int( Math.random() * 3 ) ];
		}
	}
}