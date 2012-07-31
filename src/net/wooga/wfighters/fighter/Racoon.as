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
				new FrameConfig( "punch0",		new Assets.PandaPunch0Bitmap(), new Vector3D( -25, 0 ) ),
				new FrameConfig( "punch1",		new Assets.PandaPunch1Bitmap(), new Vector3D( -25, 0 ) ),
				new FrameConfig( "punch2",		new Assets.PandaPunch2Bitmap(), new Vector3D( -25, 0 ) ),
				new FrameConfig( "kick0",		new Assets.PandaKick0Bitmap(), new Vector3D( -50, 5 ) ),
				new FrameConfig( "kick1",		new Assets.PandaKick1Bitmap(), new Vector3D( -50, 5 ) ),
				new FrameConfig( "kick2",		new Assets.PandaKick2Bitmap(), new Vector3D( -50, 5 ) ),
				new FrameConfig( "jumppunch",	new Assets.PandaJumpPunchBitmap() ),
				new FrameConfig( "jumpkick",	new Assets.PandaJumpKickBitmap() ),
				new FrameConfig( "jump",		new Assets.PandaJumpBitmap() ),
				new FrameConfig( "block",		new Assets.PandaBlockBitmap() ),
				new FrameConfig( "damage",		new Assets.PandaDamageBitmap() ),
				new FrameConfig( "down",		new Assets.PandaDownBitmap() ),
				new FrameConfig( "ko",			new Assets.PandaKOBitmap() ),
			] );
		}
	}

}