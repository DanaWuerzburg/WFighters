package net.wooga.wfighters.fighter 
{
	import flash.geom.Vector3D;
	import net.wooga.wfighters.GameContainer;
	import net.wooga.wfighters.spriteset.FrameConfig;
	import net.wooga.wfighters.spriteset.Spriteset;

	public class Racoon extends Fighter 
	{	
		public function Racoon( gameCointainer : GameContainer, id : uint )
		{
			super( gameCointainer, id );
		}
		protected override function createSpriteset() : Spriteset
		{
			return new Spriteset( new <FrameConfig>
			[
				new FrameConfig( "stand01",		new Assets.RacoonStand01Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "stand02",		new Assets.RacoonStand02Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "walk01",		new Assets.RacoonWalk01Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "walk02",		new Assets.RacoonWalk02Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "walk03",		new Assets.RacoonWalk03Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "walk04",		new Assets.RacoonWalk04Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "punch01",		new Assets.RacoonPunch01Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "punch02",		new Assets.RacoonPunch02Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "punch03",		new Assets.RacoonPunch03Bitmap(), new Vector3D( -45, 0 ) ),
				new FrameConfig( "kick01",		new Assets.RacoonKick01Bitmap(), new Vector3D( 0, 0 ) ),
				new FrameConfig( "kick02",		new Assets.RacoonKick02Bitmap(), new Vector3D( 0, 0 ) ),
				new FrameConfig( "jumppunch01",		new Assets.RacoonJumpPunch01Bitmap() ),
				new FrameConfig( "jumpkick01",		new Assets.RacoonJumpKick01Bitmap() ),
				new FrameConfig( "jump01",			new Assets.RacoonJump01Bitmap() ),
				new FrameConfig( "jump02",			new Assets.RacoonJump02Bitmap() ),
				new FrameConfig( "jump03",			new Assets.RacoonJump03Bitmap() ),
				new FrameConfig( "jump04",			new Assets.RacoonJump04Bitmap() ),
				new FrameConfig( "jump05",			new Assets.RacoonJump05Bitmap() ),
				new FrameConfig( "jump06",			new Assets.RacoonJump06Bitmap() ),
				new FrameConfig( "jump07",			new Assets.RacoonJump07Bitmap() ),
				new FrameConfig( "jumpForward01",	new Assets.RacoonJumpFoward01Bitmap() ),
				new FrameConfig( "jumpForward02",	new Assets.RacoonJumpFoward02Bitmap() ),
				new FrameConfig( "jumpForward03",	new Assets.RacoonJumpFoward03Bitmap() ),
				new FrameConfig( "jumpForward04",	new Assets.RacoonJumpFoward04Bitmap() ),
				new FrameConfig( "jumpForward05",	new Assets.RacoonJumpFoward05Bitmap() ),
				new FrameConfig( "jumpForward06",	new Assets.RacoonJumpFoward06Bitmap() ),
				new FrameConfig( "jumpForward07",	new Assets.RacoonJumpFoward07Bitmap() ),
				new FrameConfig( "jumpBack01",		new Assets.RacoonJumpBack01Bitmap() ),
				new FrameConfig( "jumpBack02",		new Assets.RacoonJumpBack02Bitmap() ),
				new FrameConfig( "jumpBack03",		new Assets.RacoonJumpBack03Bitmap() ),
				new FrameConfig( "jumpBack04",		new Assets.RacoonJumpBack04Bitmap() ),
				new FrameConfig( "jumpBack05",		new Assets.RacoonJumpBack05Bitmap() ),
				new FrameConfig( "jumpBack06",		new Assets.RacoonJumpBack06Bitmap() ),
				new FrameConfig( "jumpBack07",		new Assets.RacoonJumpBack07Bitmap() ),
				new FrameConfig( "block",			new Assets.PandaBlockBitmap() ),
				new FrameConfig( "hit01",			new Assets.RacoonHit01Bitmap() ),
				new FrameConfig( "hit02",			new Assets.RacoonHit02Bitmap() ),
				new FrameConfig( "down",			new Assets.PandaDownBitmap() ),
				new FrameConfig( "ko",				new Assets.PandaKOBitmap() ),
			] );
		}
	}

}