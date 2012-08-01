package net.wooga.wfighters.spriteset 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	public class Spriteset extends Sprite
	{
		private var config : Vector.<FrameConfig> = new Vector.<FrameConfig>();
		private var imageMap : Dictionary = new Dictionary();
		private var currentLoadingFrame : FrameConfig;
		private var hasLoaded : Boolean = false;
		private var currentShownFrame : String;
		private var matrix : Matrix = new Matrix();
		
		public function Spriteset( config : Vector.<FrameConfig> ) 
		{
			var index : uint;
			var length : uint = config.length;
			for ( index = 0; index < length; index++ )
			{
				imageMap[ config[ index ].id ] = config[ index ];
			}
			this.config = config;
		}
		
		public function showFrame( id : String ) : void
		{
			if ( currentShownFrame != id && imageMap[ id ] )
			{
				replaceFrame( imageMap[ id ] );
				currentShownFrame = id;
			}
		}
		
		public function get currentFrameOffset() : Vector3D
		{
			return imageMap[ currentShownFrame ].offset;
		}
		
		private function replaceFrame( frame : FrameConfig ) : void
		{
			matrix.tx = frame.offset.x;
			matrix.ty = frame.offset.y;
			graphics.clear();
			graphics.beginBitmapFill( frame.bitmap.bitmapData, matrix, false );
			graphics.drawRect( frame.offset.x, frame.offset.y, frame.bitmap.bitmapData.width, frame.bitmap.bitmapData.height )
			graphics.endFill();
		}
	}
}