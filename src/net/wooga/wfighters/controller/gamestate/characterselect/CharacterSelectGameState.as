package net.wooga.wfighters.controller.gamestate.characterselect 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.media.Sound;
	import flash.text.TextField;
	import net.wooga.wfighters.controller.gamestate.versusscreen.VersusScreenGameState;
	import net.wooga.wfighters.controller.gamestate.vsmatch.ConfigureFightersGameState;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.InputController;
	import net.wooga.wfighters.controller.Sounds;
	import net.wooga.wfighters.events.PlaySoundEvent;
	import net.wooga.wfighters.fighter.Panda;
	import net.wooga.wfighters.fighter.Racoon;
	import net.wooga.wfighters.GameContainer;

	public class CharacterSelectGameState extends GameState
	{
		private const STATE_FADE_IN : String = "fadein";
		private const STATE_SELECT : String = "select";
		private const STATE_FADE_OUT : String = "fadeout";
		
		private var state : String;
		private var stateTime : Number = 0;
		
		private var background : Bitmap;
		private var selectionFrameP1 : Bitmap;
		private var selectionFrameP2 : Bitmap;
		private var selectionFrameP1P2 : Bitmap;
		
		private var characterSetList : Vector.<CharacterSet> = new Vector.<CharacterSet>();
		
		private var selection1p : int;
		private var selection2p : int;
		private var playerOneLocked : Boolean;
		private var playerTwoLocked : Boolean;
		private var playerOneColorMatrix : Array = [  2, 0, 0, 0, 0,
													  0, 2, 0, 0, 0,
													  0, 0, 2, 0, 0,
													  0, 0, 0, 2, 0 ];
		private var playerTwoColorMatrix : Array = [  2, 0, 0, 0, 0,
													  0, 2, 0, 0, 0,
													  0, 0, 2, 0, 0,
													  0, 0, 0, 2, 0 ];
		private var playerOneFilter : ColorMatrixFilter = new ColorMatrixFilter( playerOneColorMatrix );
		private var playerTwoFilter : ColorMatrixFilter = new ColorMatrixFilter( playerTwoColorMatrix );
		private var playerOneLastBigBitmap : Bitmap;
		private var playerTwoLastBigBitmap : Bitmap;
		private var playerOneCurrentBigBitmap : Bitmap;
		private var playerTwoCurrentBigBitmap : Bitmap;
		private var bigImageContainer : Sprite = new Sprite();
		private var characterName1 : TextField;
		private var characterName2 : TextField;
		private var textImage1P : Bitmap;
		private var textImage2P : Bitmap;
		private var textCharacterSelect : TextField;
		
		public function CharacterSelectGameState( gameContainer:GameContainer ) 
		{
			super( gameContainer );
			
			background = new Assets.CharacterSelectBackgroundBitmap();
			selectionFrameP1 = new Assets.CharacterSelectFrame1PBitmap();
			selectionFrameP1P2 = new Assets.CharacterSelectFrame1P2PBitmap();
			selectionFrameP2 = new Assets.CharacterSelectFrame2PBitmap();
			
			characterSetList.push( new CharacterSet( Racoon.NAME,  	new Assets.CharacterSelectPreviewSmall01Bitmap, Assets.CharacterSelectPreviewBig01Bitmap, Racoon ) );
			characterSetList.push( new CharacterSet( Panda.NAME, 	new Assets.CharacterSelectPreviewSmall02Bitmap, Assets.CharacterSelectPreviewBig02Bitmap, Panda ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall03Bitmap, Assets.CharacterSelectPreviewBig03Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall04Bitmap, Assets.CharacterSelectPreviewBig04Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall05Bitmap, Assets.CharacterSelectPreviewBig05Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall06Bitmap, Assets.CharacterSelectPreviewBig06Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall07Bitmap, Assets.CharacterSelectPreviewBig07Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall08Bitmap, Assets.CharacterSelectPreviewBig08Bitmap, null ) );
			characterSetList.push( new CharacterSet( "???",   		new Assets.CharacterSelectPreviewSmall09Bitmap, Assets.CharacterSelectPreviewBig09Bitmap, null ) );
			
			characterName1 = gameContainer.createBigTextField();
			characterName2 = gameContainer.createBigTextField();
			textImage1P = new Assets.CharacterSelect1PBitmap();
			textImage2P = new Assets.CharacterSelect2PBitmap();
			textImage1P.x = 100;
			textImage1P.y = 360;
			textImage2P.x = 540 - textImage2P.width;
			textImage2P.y = 360;
			textCharacterSelect = gameContainer.createBigTextField();
			textCharacterSelect.text = "Select your WoogaFighter!";
			textCharacterSelect.y = 4;
			textCharacterSelect.x = 320 - textCharacterSelect.width / 2;
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( background );
			gameContainer.addChild( bigImageContainer );
			
			var index : uint = 0;
			var length : uint = characterSetList.length;
			var character : CharacterSet;
			for ( index = 0; index < length; index++ )
			{
				character = characterSetList[ index ];
				gameContainer.addChild( character.smallPreview );
				character.smallPreview.y = 800;
				character.smallPreview.x = 170 + ( index % 3 ) * 100;
				character.smallPreview.filters = [];
			}
			
			gameContainer.addChild( selectionFrameP1 );
			gameContainer.addChild( selectionFrameP2 );
			gameContainer.addChild( selectionFrameP1P2 );
			
			background.alpha = 0;
			
			state = STATE_FADE_IN;
			stateTime = 0;
			selection1p = 0;
			changeSelection1P( 0 );
			selection2p = 1;
			changeSelection2P( 0 );
			playerOneLocked = false;
			playerTwoLocked = false;
			selectionFrameP1.visible = false;
			selectionFrameP2.visible = false;
			selectionFrameP1P2.visible = false;
			
			
			textImage1P.alpha = textImage2P.alpha = characterName1.alpha = characterName2.alpha = textCharacterSelect.alpha = 0;
			gameContainer.addChild( textImage1P );
			gameContainer.addChild( textImage2P );
			gameContainer.addChild( characterName1 );
			gameContainer.addChild( characterName2 );
			gameContainer.addChild( textCharacterSelect );
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( background );
			gameContainer.removeChild( bigImageContainer );
			if ( playerOneLastBigBitmap ) bigImageContainer.removeChild( playerOneLastBigBitmap );
			if ( playerTwoLastBigBitmap ) bigImageContainer.removeChild( playerTwoLastBigBitmap );
			var index : uint = 0;
			var length : uint = characterSetList.length;
			var character : CharacterSet;
			for ( index = 0; index < length; index++ )
			{
				character = characterSetList[ index ];
				gameContainer.removeChild( character.smallPreview );
			}
			
			gameContainer.removeChild( textImage1P );
			gameContainer.removeChild( textImage2P );
			gameContainer.removeChild( characterName1 );
			gameContainer.removeChild( characterName2 );
			gameContainer.removeChild( textCharacterSelect );
		}
		
		public override function update( t : int ) : void
		{
			switch( state )
			{
				case STATE_FADE_IN: updateFadeIn( t ); break;
				case STATE_SELECT: updateSelect( t ); break;
				case STATE_FADE_OUT: updateFadeOut( t ); break;
			}
			
			if ( playerOneLastBigBitmap )
			{
				playerOneLastBigBitmap.alpha = Math.max(0, playerOneLastBigBitmap.alpha - t / 300 );
				if ( playerOneLastBigBitmap.alpha == 0 )
				{
					bigImageContainer.removeChild( playerOneLastBigBitmap );
					playerOneLastBigBitmap = null;
				}
			}
			if ( playerTwoLastBigBitmap )
			{
				playerTwoLastBigBitmap.alpha = Math.max(0, playerTwoLastBigBitmap.alpha - t / 300 );
				if ( playerTwoLastBigBitmap.alpha == 0 )
				{
					bigImageContainer.removeChild( playerTwoLastBigBitmap );
					playerTwoLastBigBitmap = null;
				}
			}
			if ( playerOneCurrentBigBitmap )
			{
				playerOneCurrentBigBitmap.alpha = Math.min(1, playerOneCurrentBigBitmap.alpha + t / 300 );
			}
			if ( playerTwoCurrentBigBitmap )
			{
				playerTwoCurrentBigBitmap.alpha = Math.min(1, playerTwoCurrentBigBitmap.alpha + t / 300 );
			}
		}
		
		private function updateFadeIn( t : int ) : void
		{
			stateTime += t;
			
			background.alpha = Math.min( 1, stateTime / 200 );
			
			var index : uint = 0;
			var length : uint = characterSetList.length;
			var character : CharacterSet;
			for ( index = 0; index < length; index++ )
			{
				character = characterSetList[ index ];
				character.smallPreview.y = 80 + int( index / 3 ) * 110 + Math.max( 0, 2000 - stateTime * 3 - ( length - index ) * 100 );
			}
			
			if ( playerOneCurrentBigBitmap )
			{
				playerOneCurrentBigBitmap.x = -500 + Math.min( 1, stateTime / 200 ) * 400;
			}
			if ( playerTwoCurrentBigBitmap )
			{
				playerTwoCurrentBigBitmap.x = 1140 - Math.min( 1, stateTime / 200 ) * 400;
			}
			textImage1P.alpha = Math.min( 1, stateTime / 200 );
			textImage2P.alpha = Math.min( 1, stateTime / 200 );
			textCharacterSelect.alpha = Math.min( 1, stateTime / 200 );
			characterName1.alpha = Math.min( 1, stateTime / 200 );
			characterName2.alpha = Math.min( 1, stateTime / 200 );
			
			if ( stateTime > 1000 )
			{
				state = STATE_SELECT;
				stateTime = 0;
			}
			
		}
		
		private function updateSelect( t : int ) : void
		{
			stateTime += t;
			
			if ( ! playerOneLocked )
			{
				if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.upKey ) )
				{
					if ( selection1p >= 3 ) changeSelection1P( -3 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.downKey ) )
				{
					if ( selection1p < 6 ) changeSelection1P( 3 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.leftKey ) )
				{
					if ( int( selection1p % 3 ) > 0 ) changeSelection1P(-1 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.rightKey ) )
				{
					if ( int( selection1p % 3 ) < 2 ) changeSelection1P( 1 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.punchKey ) )
				{
					if ( ( selection1p != selection2p || !playerTwoLocked ) && characterSetList[ selection1p ].characterClass != null )
					{
						playerOneLocked = true;
						characterSetList[ selection1p ].smallPreview.filters = [ playerOneFilter ];
						gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.MENU_OK1 ) );
					}
				}
			}
			
			if ( !playerTwoLocked )
			{
				if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.upKey ) )
				{
					if ( selection2p >= 3 ) changeSelection2P( - 3 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.downKey ) )
				{
					if ( selection2p < 6 ) changeSelection2P ( 3 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.leftKey ) )
				{
					if ( int( selection2p % 3 ) > 0 ) changeSelection2P( -1 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.rightKey ) )
				{
					if ( int( selection2p % 3 ) < 2 ) changeSelection2P( 1 );
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.punchKey ) )
				{
					if ( ( selection1p != selection2p || !playerOneLocked ) && characterSetList[ selection2p ].characterClass != null )
					{
						playerTwoLocked = true;
						characterSetList[ selection2p ].smallPreview.filters = [ playerTwoFilter ];
						gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.MENU_OK1 ) );
					}
				}
			}
			updatePlayerSelectionFrames( stateTime );
			
			if ( playerOneLocked && playerTwoLocked )
			{
				state = STATE_FADE_OUT;
				stateTime = 0;
				selectionFrameP1.visible = false;
 				selectionFrameP2.visible = false;
				selectionFrameP1P2.visible = false;
			}
		}
		
		private function changeSelection1P( offset : int ) : void
		{
			if ( playerOneLastBigBitmap )
			{
				bigImageContainer.removeChild( playerOneLastBigBitmap );
			}
			playerOneLastBigBitmap = playerOneCurrentBigBitmap;
			selection1p += offset;
			playerOneCurrentBigBitmap = Assets.createBitmap( characterSetList[ selection1p ].bigPreviewClass );
			playerOneCurrentBigBitmap.alpha = 0;
			playerOneCurrentBigBitmap.x = -100;
			bigImageContainer.addChild( playerOneCurrentBigBitmap );
			
			characterName1.text = characterSetList[ selection1p ].name;
			characterName1.x = 20;
			characterName1.y = 400;
			
			gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.MENU_SELECT ) );
		}
		
		private function changeSelection2P( offset : int ) : void
		{
			if ( playerTwoLastBigBitmap )
			{
				bigImageContainer.removeChild( playerTwoLastBigBitmap );
			}
			playerTwoLastBigBitmap = playerTwoCurrentBigBitmap;
			selection2p += offset;
			playerTwoCurrentBigBitmap = Assets.createBitmap( characterSetList[ selection2p ].bigPreviewClass );
			playerTwoCurrentBigBitmap.alpha = 0;
			playerTwoCurrentBigBitmap.x = 740;
			playerTwoCurrentBigBitmap.scaleX = -1;
			bigImageContainer.addChild( playerTwoCurrentBigBitmap );
			
			characterName2.text = characterSetList[ selection2p ].name;
			characterName2.x = 620 - characterName2.width;
			characterName2.y = 400;
			
			gameContainer.stage.dispatchEvent( new PlaySoundEvent( Sounds.MENU_SELECT ) );
		}
		
		private function updatePlayerSelectionFrames( stateTime : Number ) : void
		{
			selectionFrameP1P2.visible = selection1p == selection2p;
			selectionFrameP1.visible = selectionFrameP2.visible = selection1p != selection2p;
			
			selectionFrameP1P2.x = selectionFrameP1.x = 170 + ( selection1p % 3 ) * 100;
			selectionFrameP1P2.y = selectionFrameP1.y = 80 + int( selection1p / 3 ) * 110;
			
			selectionFrameP2.x = 170 + ( selection2p % 3 ) * 100;
			selectionFrameP2.y = 80 + int( selection2p / 3 ) * 110;
		}
		
		private function updateFadeOut( t : int ) : void
		{
			stateTime += t;
			
			background.alpha = Math.max( 0, 1 - stateTime / 200 );
			
			var index : uint = 0;
			var length : uint = characterSetList.length;
			var character : CharacterSet;
			for ( index = 0; index < length; index++ )
			{
				character = characterSetList[ index ];
				character.smallPreview.y = 80 + int( index / 3 ) * 110 - Math.max( 0, stateTime * 3 - 100 * index );
			}
			
			if ( playerOneCurrentBigBitmap )
			{
				playerOneCurrentBigBitmap.x = -100 - Math.min( 1, stateTime / 200 ) * 400;
			}
			if ( playerTwoCurrentBigBitmap )
			{
				playerTwoCurrentBigBitmap.x = 740 + Math.min( 1, stateTime / 200 ) * 400;
			}
			textImage1P.alpha = Math.min( 1, 1 - stateTime / 200 );
			textImage2P.alpha = Math.min( 1, 1 - stateTime / 200 );
			textCharacterSelect.alpha = Math.min( 1, 1 - stateTime / 200 );
			characterName1.alpha = Math.min( 1, 1 - stateTime / 200 );
			characterName2.alpha = Math.min( 1, 1 - stateTime / 200 );
			
			if ( stateTime > 1000 )
			{
				gameContainer.gameController.changeGameState(
					new VersusScreenGameState(
						gameContainer,
						characterSetList[ selection1p ],
						characterSetList[ selection2p ]
						)
					);
			}
		}
	}
}