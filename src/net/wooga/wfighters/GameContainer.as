package net.wooga.wfighters 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class GameContainer extends Sprite
	{
		private var pressedKeys : Dictionary;
		
		public function GameContainer() 
		{
			super();
			
			pressedKeys = new Dictionary();
			
			setup();
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToState );
		}
		
		private function setup() : void
		{
			graphics.beginFill( 0x000000 );
			graphics.drawRect( 0, 0, 640, 480 )
			graphics.endFill();
		}
		
		private function handleAddedToState( e : Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToState );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, handleKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, handleKeyDown );
		}
		
		private function handleKeyDown( e : KeyboardEvent ) : void 
		{
			pressedKeys[ e.keyCode ] = e.keyCode;
		}
		
		private function handleKeyUp( e : KeyboardEvent ) : void 
		{
			delete pressedKeys[ e.keyCode ];
		}
		
	}

}