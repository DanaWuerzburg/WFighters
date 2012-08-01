package net.wooga.wfighters.fighter 
{
	import flash.display.Sprite;
	import net.wooga.wfighters.spriteset.Spriteset;

	public class Bullet extends Sprite 
	{
		private var animTimeRest : Number = 0;
		private var animTime : Number = 0;
		private var spriteset : Spriteset;
		
		public function Bullet( spriteset : Spriteset ) 
		{
			this.spriteset = spriteset;
			addChild( spriteset );
		}
		
		public function update( t : uint ) : void
		{
			animTime += t;
			animTimeRest = animTimeRest % 300;
			spriteset.showFrame(
				animTimeRest < 50 ?  "bullet01" : 
				animTimeRest < 150 ? "bullet02" : 
				animTimeRest < 100 ? "bullet03" :
				animTimeRest < 200 ? "bullet04" : 
				animTimeRest < 250 ? "bullet05" :
									 "bullet06"
			);
		}
	}
}