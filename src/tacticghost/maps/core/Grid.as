package tacticghost.maps.core
{
	
	public class Grid
	{
		private var _startNode:Node;
		private var _endNode:Node;
		private var _nodes:Array;
		private var _numCols:int;
		private var _numRows:int;
		
		public function Grid(numCols:int,numRows:int)
		{
			_numCols = numCols;
			_numRows = numRows;
			
			_nodes = new Array();
			
			var i:int;
			var j:int;
			
			for(i=0; i<_numCols; i++)
			{
				_nodes[i] = new Array();
				for(j=0; j<_numRows; j++)
				{
					_nodes[i][j] = new Node(i,j);
				}
			}
			
		}
		
		public function getNode(x:int, z:int):Node
		{
			return _nodes[x][z] as Node;
		}
		
		public function setEndNode(x:int,z:int):void
		{
			_endNode = _nodes[x][z] as Node;
		}
		
		public function setStartNode(x:int,z:int):void
		{
			_startNode = _nodes[x][z] as Node;
		}
		
		public function clearWalkable():void
		{
			var i:int;
			var j:int;
			
			for(i=0; i<_numCols; i++)
			{
				for(j=0; j<_numRows; j++)
				{
					_nodes[i][j].walkable = true;
				}
			}
		}
		
		public function setWalkable(x:int,z:int,value:Boolean):void
		{
			_nodes[x][z].walkable = value;
		}
		
		public function setUserData(x:int,z:int,data:*):void
		{
			_nodes[x][z].userData = data;
		}
		
		public function get endNode():Node
		{
			return _endNode;
		}
		
		public function get numCols():int
		{
			return _numCols;
		}
		
		public function get numRows():int
		{
			return _numRows;
		}
		
		public function get startNode():Node
		{
			return _startNode;
		}
	}
}