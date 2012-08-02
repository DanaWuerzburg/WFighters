package net.wooga.wfighters.controller.gamestate.characterselect 
{
	import flash.display.Bitmap;
	public class CharacterSet 
	{
		public var smallPreview : Bitmap;
		public var bigPreviewClass : Class;
		public var characterClass : Class;
		public var name : String;
		
		public function CharacterSet( name : String, smallPreview : Bitmap, bigPreviewClass : Class, characterClass : Class ) 
		{
			this.smallPreview = smallPreview;
			this.bigPreviewClass = bigPreviewClass;
			this.characterClass = characterClass;
			this.name = name;
		}	
	}
}