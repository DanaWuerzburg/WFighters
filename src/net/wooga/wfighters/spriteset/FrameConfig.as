package net.wooga.wfighters.spriteset 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.geom.Vector3D;
	internal class FrameConfig 
	{
		private var _id : String;
		private var _image : Loader;
		private var _offset : Vector3D;
		
		public function FrameConfig( id : String, image : Loader, offset : Vector3D ) 
		{
			_id = id;
			_image = image;
			_offset = offset;
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get image() : Loader
		{
			return _image;
		}
		
		public function get offset() : Vector3D
		{
			return _offset;
		}
		
	}

}