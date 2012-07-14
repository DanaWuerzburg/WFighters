package net.wooga.wfighters.spriteset 
{
	import flash.geom.Vector3D;
	
	public class FrameLoaderConfig 
	{
		private var _id : String;
		private var _path : String;
		private var _offset : Vector3D;
		
		public function FrameLoaderConfig( id : String, path : String, offset : Vector3D = null ) 
		{
			_id = id;
			_path = path;
			_offset = offset ? offset : new Vector3D();
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get path() : String
		{
			return _path;
		}
		
		public function get offset() : Vector3D
		{
			return _offset;
		}
		
	}

}