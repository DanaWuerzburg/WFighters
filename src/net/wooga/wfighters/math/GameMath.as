package net.wooga.wfighters.math
{
	public class GameMath
	{
		public static function clamp( number : Number, minimum : Number, maximum : Number ) : Number
		{
			if( number < minimum ) return minimum;
			if( number > maximum ) return maximum;
			return number;
		}
	}
}