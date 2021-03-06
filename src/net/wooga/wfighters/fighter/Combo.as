package net.wooga.wfighters.fighter 
{
	import flash.utils.Dictionary;
	public class Combo 
	{
		public static const KICK : String = "KICK";
		public static const PUNCH : String = "PUNCH";
		public static const JUMP : String = "JUMP";
		public static const FORWARD : String = "FORWARD";
		public static const BACK : String = "BACK";
		
		private var subComboDict : Dictionary = new Dictionary();
		private var callback : Function;
		private var _canFail : Boolean = false;
		
		public function Combo( callback : Function = null ) 
		{
			this.callback = callback;
		}
		
		public function addCombo( trigger : String, combo : Combo ) : Combo
		{
			subComboDict[ trigger ] = combo;
			return this;
		}
		
		public function execute() : void
		{
			callback && callback();
		}
		
		public function trigger( trigger : String ) : Combo
		{
			if ( subComboDict[ trigger ] )
			{
				var subCombo : Combo = subComboDict[ trigger ] as Combo;
				subCombo.execute();
				return subCombo;
			}
			else if ( _canFail )
			{
				return null;
			}
			else
			{
				return this;
			}
		}
		
		public function get canFail() : Boolean
		{
			return _canFail;
		}
		
		public function set canFail( canFail : Boolean ) : void
		{
			_canFail = canFail;
		}
	}
}