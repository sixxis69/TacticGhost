package tacticghost.maps.core
{
	import com.greensock.TweenLite;
	
	import flare.core.Pivot3D;
	import flare.events.MouseEvent3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.primitives.Cube;
	import flare.primitives.Plane;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	
	import tacticghost.maps.core.AStar;
	import tacticghost.maps.core.Grid;
	import tacticghost.player.core.PlayerTemplate;
	import tacticghost.player.events.PlayerEvent;
	
	public class MapTemplate extends Pivot3D
	{
		public static const UNIT_SIZE:int = 10;
		
		protected var minX:int;
		protected var minZ:int;
		protected var maxX:int;
		protected var maxZ:int;
		
		protected var pathGroup:Vector.<WalkPlane>;
		protected var grid:Grid;
		
		protected var cursor:CursorPlane;
		protected var currentPlayer:PlayerTemplate;
		
		public function getNodeX(value:int):int
		{
			return (value-minX)/UNIT_SIZE;	
		}
		
		public function getNodeZ(value:int):int
		{
			return (minZ-value)/UNIT_SIZE;
		}
		
		public function getX(tx:int):int
		{
			return minX + tx*UNIT_SIZE;
		}
		
		public function getZ(tz:int):int
		{
			return minZ - tz*UNIT_SIZE;
		}
		
		public function MapTemplate(name:String="")
		{
			super(name);
			
			pathGroup = new Vector.<WalkPlane>();
		}

		protected function loadModel():void
		{
			// NOTE: define in subclass
		}
		
		protected function createGrid(numRows:int=20,numColumns:int=20):void
		{
			grid = new Grid(numRows,numColumns);
			
//			var plane:Plane = new Plane('floor',numRows*UNIT_SIZE,numColumns*UNIT_SIZE,1,null,"+xz");
//			this.addChild(plane);
			
			// assign limit value
			minX = -(numRows*UNIT_SIZE)/2 + UNIT_SIZE/2;
			minZ = (numColumns*UNIT_SIZE)/2 - UNIT_SIZE/2;
			maxX = minX + (numRows-1)*UNIT_SIZE;
			maxZ = minZ - (numColumns-1)*UNIT_SIZE;
			
			// create cursor
			cursor = new CursorPlane();
			cursor.x = getX(0);
			cursor.z = getZ(0);
			this.addChild(cursor);
		}
		
		protected function findPath():void
		{
			var astar:AStar = new AStar();
			if(astar.findPath(grid))
			{
				// NOTE: MOVE player
				movePlayer(astar.path);
//				currentPlayer.walk(astar.path);
//				showPath(astar);
			}
			else
			{
				// NOTE: not found path
			}
		}
		
		protected var timer:Timer;
		protected function movePlayer(list:Vector.<Node>):void
		{
			// TODO: have to change algorithm
			
			
			
			var i:int;
			var n:Node;
			var numStep:int = list.length;
			var tx:int;
			var tz:int;
			
			// clear user node
			tx = getNodeX(currentPlayer.x);
			tz = getNodeZ(currentPlayer.z);
			n = grid.getNode(tx,tz);
			n.userData = null;
			n.walkable = true;
			
			// remove plane		
			while(pathGroup.length > 0)
			{
				this.removeChild(pathGroup[0]);
				pathGroup.shift();
			}
			
			// create animate
			timer = new Timer(300,numStep);
			timer.addEventListener(TimerEvent.TIMER, onUpdateStep);
			
			timer.start();
			
			function onUpdateStep(e:TimerEvent):void
			{
				tx = getX(list[i].x);
				tz = getZ(list[i].z);
				TweenLite.to(currentPlayer,0.2,{x:tx,z:tz});
				i++;
				
				// complete
				if(i >= numStep){
					timer.removeEventListener(TimerEvent.TIMER, onUpdateStep);
					
					tx = list[numStep-1].x;
					tz = list[numStep-1].z;
					grid.setWalkable(tx,tz,false);
					grid.setUserData(tx,tz,currentPlayer);
				}
			}
		}
		
		
		
		public function addPlayer(p:Pivot3D,tx:int,tz:int):void
		{
			this.addChild(p);
			p.x = getX(tx);
			p.z = getZ(tz);
			
			grid.setWalkable(tx,tz,false);
			grid.setUserData(tx,tz,p);
		}
		
		public function moveCursor(nx:int,nz:int):void
		{
			cursor.x += nx*UNIT_SIZE;
			cursor.z += -nz*UNIT_SIZE;
			
			cursor.x = Math.max(cursor.x,minX); 
			cursor.x = Math.min(cursor.x,maxX);
			
			cursor.z = Math.min(cursor.z,minZ);
			cursor.z = Math.max(cursor.z,maxZ);
		}
		
		public function openAction():void
		{
			var i:int;
			var nx:int = getNodeX(cursor.x);
			var nz:int = getNodeZ(cursor.z);
			var node:Node = grid.getNode(nx,nz);
			
			// TODO: define each action, open menu, selecte grid, check enemy status
			// NOTE: select node to walk
			if(pathGroup.length > 0)
			{
				var pathX:int;
				var pathZ:int;
				for(i=0; i<pathGroup.length; i++)
				{
					pathX = getNodeX(pathGroup[i].x);
					pathZ = getNodeZ(pathGroup[i].z);
					if(pathX == nx && pathZ == nz)
					{
						grid.setEndNode(nx,nz);
						findPath();
					}
				}
				return;
			}
			
			// NOTE: open menu (walk, attack, etc)
			if(node.userData)
			{
				// get list
				currentPlayer = node.userData as PlayerTemplate;
				grid.setStartNode(nx,nz);
				var list:Vector.<Node> = currentPlayer.getWalkNode(nx,nz);
				
				// remove node which out of bound
				for(i=list.length-1; i>=0; i--)
				{
					if(list[i].x < 0 || list[i].z < 0 || list[i].x >= grid.numCols || list[i].z >= grid.numRows)
					{
						list.splice(i,1);
					}
				}
				
				// add walk plane
				var c:WalkPlane;
				for(i=0; i<list.length; i++)
				{
					c = new WalkPlane();
					c.x = getX(list[i].x);
					c.z = getZ(list[i].z);
					this.addChild(c);
					pathGroup.push(c);
				}
			}
		}
		
		override public function update():void
		{
			var i:int;
			for(i=0; i<pathGroup.length; i++)
			{
				pathGroup[i].updateAnimate();
			}
			
			cursor.updateAnimate();
			
			super.update();
		}
		
	}
}