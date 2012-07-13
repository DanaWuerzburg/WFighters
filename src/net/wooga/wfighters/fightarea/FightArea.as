package net.wooga.wfighters.fightarea 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import net.wooga.wfighters.fighter.Fighter;
	public class FightArea extends Sprite
	{
		
		private var fighterList : Vector.<Fighter> = new Vector.<Fighter>();
		
		private var boundsRect : Rectangle = new Rectangle( 0, 0, 1280, 480 );
		private var cameraRectangle : Rectangle = new Rectangle( 0, 0, 640, 480 );
		
		private var index : uint;
		private var length : uint;
		
		public function FightArea() 
		{
			
		}
		
		public function addFighter( fighter : Fighter ) : void
		{
			fighterList.push( fighter );
			fighter.fightArea = this;
			addChild( fighter );
		}
		
		public function handleFighterPositionChanged( fighter : Fighter ) : void
		{
			if ( fighter.x < boundsRect.x ) fighter.x = boundsRect.x;
			if ( fighter.x + fighter.width > boundsRect.width ) fighter.x = boundsRect.width - fighter.width;
			
			if (	fighter.x + fighter.width > cameraRectangle.right &&
					!tryMoveCamera( fighter.x + fighter.width - cameraRectangle.right ) )
			{
				fighter.x = cameraRectangle.right - fighter.width;
			}
			if (	fighter.x < cameraRectangle.left &&
					!tryMoveCamera( fighter.x - cameraRectangle.left ) )
			{
				fighter.x = cameraRectangle.left;
			}
		}
		
		public function tryMoveCamera( offset : Number ) : Boolean
		{
			var canMove : Boolean = true;
			length = fighterList.length;
			for ( index = 0; index < length; index++ )
			{
				if (	fighterList[ index ].x < cameraRectangle.left + offset ||
						fighterList[ index ].x + fighterList[ index ].width > cameraRectangle.right + offset )
				{
					canMove = false;
					break;
				}
			}
			if ( canMove )
			{
				cameraRectangle.x += offset;
				updateCamera();
			}
			return canMove;
		}
		
		public function updateCamera() : void
		{
			x = -cameraRectangle.x;
		}
		
	}
}