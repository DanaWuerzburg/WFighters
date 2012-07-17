package net.wooga.wfighters.spriteset 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Vector3D;
	import flash.sampler.NewObjectSample;
	
	public class FrameConfig 
	{
		private var _id : String;
		private var _bitmap : Bitmap;
		private var _offset : Vector3D;
		
		public function FrameConfig( id : String, bitmap : Bitmap, offset : Vector3D = null ) 
		{
			_id = id;
			_bitmap = bitmap;
			_offset = offset ? offset : new Vector3D();
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get bitmap() : Bitmap
		{
			return _bitmap;
		}
		
		public function get offset() : Vector3D
		{
			return _offset;
		}
	}

}