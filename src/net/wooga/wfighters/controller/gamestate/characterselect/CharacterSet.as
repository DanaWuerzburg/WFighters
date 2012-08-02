package net.wooga.wfighters.controller.gamestate.characterselect 
{
	import flash.display.Bitmap;
	public class CharacterSet 
	{
		public var smallPreview : Bitmap;
		public var bigPreview : Bitmap;
		public var characterClass : Class;
		
		public function CharacterSet( smallPreview : Bitmap, bigPreview : Bitmap, characterClass : Class ) 
		{
			this.smallPreview = smallPreview;
			this.bigPreview = bigPreview;
			this.characterClass = characterClass;
		}	
	}
}