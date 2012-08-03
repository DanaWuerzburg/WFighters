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
		
		/** 
		 * Performs a linear interpolation 
		 * 
		 * @param 	x		The starting value
		 * @param 	y		The ending value
		 * @param 	amount	How far between the values we are. E.g. 0 = x, 1.0 = y, and 0.5 is halfway between x and y 
		 * @return The interpolated value
		 */		
		public static function lerp( x : Number, y : Number, amount : Number ) : Number
		{
			return (1 - amount) * x + amount * y;
		}
	}
}