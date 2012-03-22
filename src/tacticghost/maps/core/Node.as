package tacticghost.maps.core
{
	public class Node
	{
		public var x:int;
		public var z:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:Node;
		public var userData:*;
		
		public function Node(x:int,z:int)
		{
			this.x = x;
			this.z = z;
		}
	}
}