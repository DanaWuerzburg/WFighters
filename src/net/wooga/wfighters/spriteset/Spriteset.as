package net.wooga.wfighters.spriteset 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	public class Spriteset extends Sprite
	{
		private var imagePathList : Vector.<FrameLoaderConfig>;
		private var loadedImageList : Vector.<FrameConfig> = new Vector.<FrameConfig>();
		private var loadedImageMap : Dictionary = new Dictionary();
		private var currentLoadingFrame : FrameConfig;
		private var hasLoaded : Boolean = false;
		private var currentShownFrame : String;
		
		public function Spriteset( imageList : Vector.<FrameLoaderConfig> ) 
		{
			this.imagePathList = imageList;
		}
		
		public function load() : void
		{
			loadImage();
		}
		
		public function showFrame( id : String ) : void
		{
			if ( hasLoaded && currentShownFrame != id && loadedImageMap[ id ] )
			{
				replaceFrame( loadedImageMap[ id ] );
				currentShownFrame = id;
			}
		}
		
		private function replaceFrame( frame : FrameConfig ) : void
		{
			while ( numChildren > 0 )
			{
				removeChildAt( 0 );
			}
			addChild( frame.image );
			frame.image.x = frame.offset.x;
			frame.image.y = frame.offset.y;
		}
		
		private function loadImage() : void
		{
			if ( imagePathList.length > loadedImageList.length )
			{
				currentLoadingFrame = new FrameConfig( imagePathList[ loadedImageList.length ].id, new Loader(), imagePathList[ loadedImageList.length ].offset );
				currentLoadingFrame.image.contentLoaderInfo.addEventListener( Event.COMPLETE, handleLoadedImage );
				currentLoadingFrame.image.load( new URLRequest( imagePathList[ loadedImageList.length ].path ) );
				addChild( currentLoadingFrame.image );
			}
			else
			{
				hasLoaded = true;
				while ( numChildren > 0 )
				{
					removeChildAt( 0 );
				}
			}
		}
		
		private function handleLoadedImage( event : Event ) : void
		{
			currentLoadingFrame.image.contentLoaderInfo.removeEventListener( Event.COMPLETE, handleLoadedImage );
			loadedImageList.push( currentLoadingFrame );
			loadedImageMap[ currentLoadingFrame.id ] = currentLoadingFrame;
			loadImage();
		}
	}
}