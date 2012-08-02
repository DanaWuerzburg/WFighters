package net.wooga.wfighters.controller.gamestate.vsmatch 
{
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.gui.GradientEffect;
	import net.wooga.wfighters.controller.gamestate.GameState;
	
	public class KOGameState extends GameState 
	{
		private var animationLayer : Sprite;
		private var shadowTextField : TextField;
		private var gradientMask : GradientEffect;
		private var textField : TextField;
		private var time : Number = 0;
		
		private var koPlayerId : uint;
		
		public function KOGameState( gameContainer : GameContainer, koPlayerId : uint )
		{
			super( gameContainer );
			
			this.koPlayerId = koPlayerId;
			
			animationLayer = new Sprite();

		}
		
		public override function handleBecomeActive() : void
		{
			trace("Entered KO game state");
			gameContainer.addChild( animationLayer );
			
			var font : Font = new Assets.QuartziteFont();
			var format:TextFormat = new TextFormat();
			format.font = font.fontName;
			format.size = 120;
			
			shadowTextField = new TextField();
			shadowTextField.embedFonts = true;
			shadowTextField.autoSize = TextFieldAutoSize.LEFT;
			shadowTextField.antiAliasType = AntiAliasType.ADVANCED;
			shadowTextField.defaultTextFormat = format;
			var outline:GlowFilter=new GlowFilter(0x000000,1.0,10,10,30);
			outline.quality = BitmapFilterQuality.MEDIUM;
			shadowTextField.filters = [ outline ];
			animationLayer.addChild( shadowTextField );
			
			textField = new TextField();
			textField.embedFonts = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.defaultTextFormat = format;
			animationLayer.addChild( textField );
			
			gradientMask = new GradientEffect();
			animationLayer.addChild( gradientMask );
			gradientMask.mask = textField;
			
			shadowTextField.text = textField.text = "K.O.";
			
			gradientMask.scaleY = textField.scaleY = shadowTextField.scaleY = 0;
			gradientMask.scaleX = textField.scaleX = shadowTextField.scaleX = 2;
			gradientMask.x = textField.x = shadowTextField.x = 320 - textField.width / 2;
			gradientMask.y = textField.y = shadowTextField.y = 240 - textField.height / 2;
		}
		
		public override function handleResignActive() : void
		{
			gameContainer.removeChild( animationLayer );
		}
		
		public override function update( t : int ) : void
		{
			time += t;
			
			if ( time < 300 )
			{
				gradientMask.scaleY = textField.scaleY = shadowTextField.scaleY = time / 150;
				gradientMask.x = textField.x = shadowTextField.x = 320 - textField.width / 2;
				gradientMask.y = textField.y = shadowTextField.y = 240 - textField.height / 2;
			}
			else if ( time > 2000 && time < 2300 )
			{
				gradientMask.scaleY = textField.scaleY = shadowTextField.scaleY = ( 2300 - time ) / 150;
				gradientMask.x = textField.x = shadowTextField.x = 320 - textField.width / 2;
				gradientMask.y = textField.y = shadowTextField.y = 240 - textField.height / 2;
			}
			else if ( time >= 2300 && time < 3000 )
			{
				
				gradientMask.scaleY = textField.scaleY = shadowTextField.scaleY = 0;	
			}
			else if ( time >= 5000 )
			{
				gameContainer.gameController.changeGameState( new EndOfRoundGameState( gameContainer, koPlayerId ) );
			}
			
			gradientMask.drawEffect( textField.width, textField.height, 5, time );
			gameContainer.fightArea.update( time < 3000 ? t / 8 : t );
		}
	}
}