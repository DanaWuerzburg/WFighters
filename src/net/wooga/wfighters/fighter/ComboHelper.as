package net.wooga.wfighters.fighter 
{
	import flash.filters.ConvolutionFilter;
	import flash.utils.Dictionary;
	public class ComboHelper 
	{
		private var comboList : Vector.<Combo> = new Vector.<Combo>;
		private var base : Combo;
		private var current : Combo;
		
		public function ComboHelper( base : Combo ) 
		{
			this.base = base;
			reset();
		}
		
		public function trigger( trigger : String ) : void
		{
			current = current.trigger( trigger );
		}
		
		public function reset() : void
		{
			current = base;
		}
	}

}