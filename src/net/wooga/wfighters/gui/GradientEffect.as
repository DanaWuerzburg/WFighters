package net.wooga.wfighters.gui 
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class GradientEffect extends Sprite 
	{
		private var gradientMatrix : Matrix;
		
		public function GradientEffect() 
		{
			gradientMatrix = new Matrix();
		}
		
		public function drawEffect( width : Number, height : Number, repeat : Number = 2, offset : Number = 0) : void
		{
			graphics.clear();
			
			gradientMatrix.createGradientBox( width / repeat, height / repeat, Math.PI / 4 * 3, offset, offset );
			
			graphics.beginGradientFill( GradientType.LINEAR, [0xFFFF00, 0xFF0000], [1, 1], [0x00, 0xFF], gradientMatrix, SpreadMethod.REFLECT );
			graphics.drawRect( 0, 0, width, height );
			graphics.endFill();
			
		}
	}

}