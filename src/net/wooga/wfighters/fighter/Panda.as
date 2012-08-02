package net.wooga.wfighters.fighter 
{
	import flash.geom.Vector3D;
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.spriteset.FrameConfig;
	import net.wooga.wfighters.spriteset.Spriteset;

	public class Panda extends Fighter 
	{	
		public static const NAME : String = "KenDa";
		
		public override function get name() : String
		{
			return NAME;
		}
		
		public function Panda( gameCointainer : GameContainer, id : uint )
		{
			super( gameCointainer, id );
		}
		
		protected override function createSpriteset() : Spriteset
		{
			return new Spriteset( new <FrameConfig>
			[
				new FrameConfig( "stand01",			new Assets.PandaStand01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "stand02",			new Assets.PandaStand02Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "walk01",			new Assets.PandaWalk01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "walk02",			new Assets.PandaWalk02Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "walk03",			new Assets.PandaWalk03Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "walk04",			new Assets.PandaWalk04Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "punch01",			new Assets.PandaPunch01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "punch02",			new Assets.PandaPunch02Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "punch03",			new Assets.PandaPunch03Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "kick01",			new Assets.PandaKick01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "kick02",			new Assets.PandaKick02Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumppunch01",		new Assets.PandaJumpPunch01Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpkick01",		new Assets.PandaJumpKick01Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump01",			new Assets.PandaJump01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump02",			new Assets.PandaJump02Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump03",			new Assets.PandaJump03Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump04",			new Assets.PandaJump04Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump05",			new Assets.PandaJump05Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump06",			new Assets.PandaJump06Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jump07",			new Assets.PandaJump07Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward01",	new Assets.PandaJumpFoward01Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward02",	new Assets.PandaJumpFoward02Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward03",	new Assets.PandaJumpFoward03Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward04",	new Assets.PandaJumpFoward04Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward05",	new Assets.PandaJumpFoward05Bitmap(),	 	new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward06",	new Assets.PandaJumpFoward06Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpForward07",	new Assets.PandaJumpFoward07Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack01",		new Assets.PandaJumpBack01Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack02",		new Assets.PandaJumpBack02Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack03",		new Assets.PandaJumpBack03Bitmap(), 		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack04",		new Assets.PandaJumpBack04Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack05",		new Assets.PandaJumpBack05Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack06",		new Assets.PandaJumpBack06Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "jumpBack07",		new Assets.PandaJumpBack07Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "block01",			new Assets.PandaBlockBitmap(),				new Vector3D( -80, 90 ) ),
				new FrameConfig( "hit01",			new Assets.PandaHit01Bitmap(), 			new Vector3D( -80, 90 ) ),
				new FrameConfig( "hit02",			new Assets.PandaHit02Bitmap(),			 	new Vector3D( -80, 90 ) ),
				new FrameConfig( "special01",		new Assets.PandaFireball01Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "special02",		new Assets.PandaFireball02Bitmap(),		new Vector3D( -80, 90 ) ),
				new FrameConfig( "ko01",			new Assets.PandaKo01Bitmap(),			 	new Vector3D( -80, 90 ) ),
				new FrameConfig( "ko02",			new Assets.PandaKo02Bitmap(),			 	new Vector3D( -80, 90 ) ),
				new FrameConfig( "ko03",			new Assets.PandaKo03Bitmap(),			 	new Vector3D( -80, 90 ) ),
				new FrameConfig( "ko04",			new Assets.PandaKo04Bitmap(),			 	new Vector3D( -80, 90 ) )
			] );
		}
		
		protected override function createBulletSpriteset() : Spriteset
		{
			return new Spriteset( new <FrameConfig>
			[
				new FrameConfig( "bullet01",			new Assets.Fireball01Bitmap() ),
				new FrameConfig( "bullet02",			new Assets.Fireball02Bitmap() ),
				new FrameConfig( "bullet03",			new Assets.Fireball03Bitmap() ),
				new FrameConfig( "bullet04",			new Assets.Fireball04Bitmap() ),
				new FrameConfig( "bullet05",			new Assets.Fireball05Bitmap() ),
				new FrameConfig( "bullet06",			new Assets.Fireball06Bitmap() )
			] );
		}
	}

}