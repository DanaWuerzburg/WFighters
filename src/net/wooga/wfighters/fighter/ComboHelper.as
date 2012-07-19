package net.wooga.wfighters.fighter 
{
	import flash.filters.ConvolutionFilter;
	import flash.utils.Dictionary;
	public class ComboHelper 
	{
		private static const KICK : String = "KICK";
		private static const PUNCH : String = "PUNCH";
		private static const JUMP : String = "JUMP";
		private static const RESULT : String = "RESULT";
		private static const lib : Object =
		{
			PUNCH :
			{
				RESULT : "singlePunch",
				PUNCH :
				{
					RESULT : "doublePunch",
					PUNCH :
					{
						RESULT : "triplePunch"
					}
				},
				KICK :
				{
					RESULT: "punchKick"
				}
			},
			KICK :
			{
				RESULT : "singleKick",
				KICK :
				{
					RESULT : "doubleKick",
					KICK :
					{
						RESULT : "tripleKick"
					}
				},
				PUNCH :
				{
					RESULT : "kickPunch"
				}
			},
			JUMP :
			{
				RESULT : "jump",
				KICK :
				{
					RESULT : "jumpKick"
				}
				PUNCH :
				{
					RESULT : "jumpPunch"
				}
			}
		}
		
		private var current : Object = lib;
		
		public function ComboHelper() 
		{
			
		}
		
		public function addPunch() : String
		{
			if ( current[ PUNCH ] )
			{
				current = current[ PUNCH ]
				return current[ RESULT ];
			}
			else return null;
		}
		
		public function addKick() : String
		{
			if ( current[ KICK ] )
			{
				current = current[ KICK ]
				return current[ RESULT ];
			}
			else return null;
		}
		
		public function addJump() : void
		{
			if ( current[ JUMP ] )
			{
				current = current[ JUMP ]
				return current[ RESULT ];
			}
			else return null;
		}
		
		public function reset() : void
		{
			current = lib;
		}
	}

}