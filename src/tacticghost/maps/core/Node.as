package tacticghost.maps.core
{
	public class Node
	{
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:Node;
		
		public function Node(x:int,y:int)
		{
			this.x = x;
			this.y = y;
		}
	}
}