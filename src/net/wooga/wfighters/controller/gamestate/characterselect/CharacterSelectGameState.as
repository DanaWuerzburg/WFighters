package net.wooga.wfighters.controller.gamestate.characterselect 
{
	import flash.display.Bitmap;
	import flash.filters.ColorMatrixFilter;
	import net.wooga.wfighters.controller.gamestate.vsmatch.ConfigureFightersGameState;
	import net.wooga.wfighters.controller.gamestate.GameState;
	import net.wooga.wfighters.controller.InputController;
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
		
		public function CharacterSelectGameState( gameContainer:GameContainer ) 
		{
			super( gameContainer );
			
			background = new Assets.CharacterSelectBackgroundBitmap();
			selectionFrameP1 = new Assets.CharacterSelectFrame1PBitmap();
			selectionFrameP1P2 = new Assets.CharacterSelectFrame1P2PBitmap();
			selectionFrameP2 = new Assets.CharacterSelectFrame2PBitmap();
			
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall01Bitmap, null, Racoon ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall02Bitmap, null, Panda ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall03Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall04Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall05Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall06Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall07Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall08Bitmap, null, null ) );
			characterSetList.push( new CharacterSet( new Assets.CharacterSelectPreviewSmall09Bitmap, null, null ) );
			
		}
		
		public override function handleBecomeActive() : void
		{
			gameContainer.addChild( background );
			
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
			selection2p = 1;
			playerOneLocked = false;
			playerTwoLocked = false;
			selectionFrameP1.visible = false;
			selectionFrameP2.visible = false;
			selectionFrameP1P2.visible = false;
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( background );
		}
		
		public override function update( t : int ) : void
		{
			switch( state )
			{
				case STATE_FADE_IN: updateFadeIn( t ); break;
				case STATE_SELECT: updateSelect( t ); break;
				case STATE_FADE_OUT: updateFadeOut( t ); break;
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
					if ( selection1p >= 3 ) selection1p -= 3;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.downKey ) )
				{
					if ( selection1p < 6 ) selection1p += 3;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.leftKey ) )
				{
					if ( int( selection1p % 3 ) > 0 ) selection1p--;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.rightKey ) )
				{
					if ( int( selection1p % 3 ) < 2 ) selection1p++;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_1.punchKey ) )
				{
					if ( selection1p != selection2p || !playerTwoLocked )
					{
						playerOneLocked = true;
						characterSetList[ selection1p ].smallPreview.filters = [ playerOneFilter ];
					}
				}
			}
			
			if ( !playerTwoLocked )
			{
				if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.upKey ) )
				{
					if ( selection2p >= 3 ) selection2p -= 3;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.downKey ) )
				{
					if ( selection2p < 6 ) selection2p += 3;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.leftKey ) )
				{
					if ( int( selection2p % 3 ) > 0 ) selection2p--;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.rightKey ) )
				{
					if ( int( selection2p % 3 ) < 2 ) selection2p++;
				}
				else if ( gameContainer.inputController.isKeyTriggered( InputController.CONTROL_CONFIG_2.punchKey ) )
				{
					if ( selection1p != selection2p || !playerOneLocked )
					{
						playerTwoLocked = true;
						characterSetList[ selection2p ].smallPreview.filters = [ playerTwoFilter ];
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
			
			if ( stateTime > 1000 )
			{
				gameContainer.gameController.changeGameState(
					new ConfigureFightersGameState(
						gameContainer,
						characterSetList[ selection1p ].characterClass,
						characterSetList[ selection2p ].characterClass
						)
					);
			}
		}
	}
}