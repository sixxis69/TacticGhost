package tacticghost.maps.core
{
	public class AStar
	{
		private var _open:Array;
		private var _closed:Array;
		private var _grid:Grid;
		private var _endNode:Node;
		private var _startNode:Node;
		private var _path:Array;
		private var _availble:Array;
		private var _heuristic:Function = euclidian;
		private var _straightCost:int = 1;
		private var _diadConst:Number = Math.SQRT2;
		
		public function AStar()
		{
		}
		
		public function findPath(grid:Grid):Boolean
		{
			_grid = grid;
			_open = new Array();
			_closed = new Array();
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
		}
		
		public function showAvailable(grid:Grid):Boolean
		{
			_grid = grid;
			
			_startNode = _grid.startNode;
			
			var range:int = 5;
			var i:int;
			var j:int;
			var startX:int 	= Math.max(0,_startNode.x-range);
			var endX:int   	= Math.min(_grid.numCols-1,_startNode.x+range);
			var startY:int 	= Math.max(0,_startNode.y-range);
			var endY:int	= Math.min(_grid.numRows-1,_startNode.y+range);
			
			_availble = [];
			var node:Node;
			for(i=startX; i<=endX; i++)
			{
				for(j=startY; j<=endY; j++)
				{
					node = _grid.getNode(i,j);
					
					if(node.walkable){
						_availble.push(node);
					}
				}
			}
			
			if(_availble.length > 0) return true;
			
			return false;
		}
		
		public function search():Boolean
		{
			var startX:int;
			var endX:int;
			var startY:int;
			var endY:int;
			
			var i:int;
			var j:int;
			var test:Node;
			var cost:int;
			
			var f:Number = 0;
			var g:Number = 0;
			var h:Number = 0;
			
			var node:Node = _startNode;
			while(node != _endNode)
			{
				startX = Math.max(0,node.x-1);
				endX = Math.min(_grid.numCols-1,node.x+1);
				startY = Math.max(0,node.y-1);
				endY = Math.min(_grid.numRows-1,node.y+1);
				
				for(i=startX; i<=endX; i++)
				{
					for(j=startY; j<=endY; j++)
					{
						test = _grid.getNode(i,j);
						if(test == node || !test.walkable) continue;
						
						cost = _straightCost;
						if(!((node.x == test.x) || (node.y == test.y)))
						{
							//							cost = _diadConst;
							continue;
						}
						
						g = node.g + cost;
						h = _heuristic(test);
						f = g+h;
						
						if(isOpen(test) || isClosed(test))
						{
							if(test.f > f)
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push(test);
						}
					}
				}
				
				_closed.push(node);
				if(_open.length == 0)
				{
					trace("no path found");
					return false;
				}
				
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as Node;
			}
			
			buildPath();
			return true;
		}
		
		private function buildPath():void
		{
			_path = new Array();
			var node:Node = _endNode;
			_path.push(node);
			while(node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		public function get path():Array
		{
			return _path;
		}
		
		private function isOpen(node:Node):Boolean
		{
			for(var i:int=0; i<_open.length; i++)
			{
				if(_open[i] == node)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function isClosed(node:Node):Boolean
		{
			for(var i:int=0; i<_closed.length; i++)
			{
				if(_closed[i] == node)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function euclidian(node:Node):Number
		{
			var dx:int = node.x - _endNode.x;
			var dy:int = node.y - _endNode.y;
			return Math.sqrt(dx*dx+dy*dy);
		}
		
		private function manhattan(node:Node):Number
		{
			return Math.abs(node.x-_endNode.x)+Math.abs(node.y+_endNode.y);
		}
		
		public function get visited():Array
		{
			return _closed.concat(_open);
		}
	}
}