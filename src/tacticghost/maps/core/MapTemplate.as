package tacticghost.maps.core
{
	import flare.core.Pivot3D;
	import flare.events.MouseEvent3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.primitives.Cube;
	import flare.primitives.Plane;
	
	import flash.geom.Vector3D;
	
	import tacticghost.maps.core.AStar;
	import tacticghost.maps.core.Grid;
	import tacticghost.player.events.PlayerEvent;
	
	public class MapTemplate extends Pivot3D
	{
		public static const initX:int = -1000+50;
		public static const initZ:int = 1000-50;
		public static const CELL_SIZE:int = 100;
		
		protected var pathContainer:Pivot3D;
		protected var cubeContainer:Pivot3D;
		protected var grid:Grid;
		
		public static function getX(tx:int):int
		{
			return initX + tx*CELL_SIZE;
		}
		
		public static function getZ(tz:int):int
		{
			return initZ - tz*CELL_SIZE;
		}
		
		public function MapTemplate(name:String="")
		{
			super(name);
			
			init();
			createObject();
		}
		
		protected function init(numRows:int=20,numColumns:int=20):void
		{
			pathContainer = new Pivot3D();
			this.addChild(pathContainer);
			
			cubeContainer = new Pivot3D();
			this.addChild(cubeContainer);
			
			grid = new Grid(numRows,numColumns);
		}
		
		protected function createDummy(tx:int,tz:int):void
		{
			var mat:Shader3D = new Shader3D('',[new ColorFilter(0x0)]);
			var box:Cube = box = new Cube('',100,100,100,1,mat);
			box.y = 50;
			box.x = initX + tx *CELL_SIZE;
			box.z = initZ - tz *CELL_SIZE;
			cubeContainer.addChild(box);
			
			grid.setWalkable(x,z,false);
		}
		
		protected function createObject():void
		{
			var plane:Plane = new Plane('floor',2000,2000,1,null,"+xz");
			this.addChild(plane);
		}
		
		protected function findPath():void
		{
			var astar:AStar = new AStar();
			if(astar.findPath(grid))
			{
				// TODO: MOVE player
				showPath(astar);
			}
		}
		
		protected function showAvailable(range:int=0):void
		{
			// TODO: define dynamic range
			
		}
		
		private function showPath(a:AStar):void
		{
			// clear
			while(pathContainer.children.length > 0)
			{
				pathContainer.removeChild(pathContainer.children[0]);
			}
			
			var mat:Shader3D = new Shader3D('',[new ColorFilter(0xff0000)]);
			var box:Cube;
			
			var path:Array = a.path;
			for(var i:int=0; i<path.length; i++)
			{
				box = new Cube('',100,2,100,1,mat);
				box.y = 1;
				box.x = getX(path[i].x);
				box.z = getZ(path[i].y);
				pathContainer.addChild(box);
			}
		}
		
		private function onCreateBox(e:MouseEvent3D):void
		{
			if(e.info != null)
			{
				var p:Vector3D = e.info.point;
				var nx:int = (p.x - initX) / CELL_SIZE;
				var nz:int = (p.z - initZ) / CELL_SIZE;
				nz *= -1;
				grid.setWalkable(nx,nz,false);
				var tx:int = getX(nx);
				var tz:int = getZ(nz);
				
				var mat:Shader3D = new Shader3D('',[new ColorFilter(0x0)]);
				var box:Cube = new Cube('',100,100,100,1,mat);
				box.y = 50;
				box.x = tx;
				box.z = tz;
				cubeContainer.addChild(box);	
			}
			findPath();
		}
		
		public function addPlayer(p:Pivot3D,tx:int,tz:int):void
		{
			cubeContainer.addChild(p);
			p.x = getX(tx);
			p.z = getZ(tz);
			p.addEventListener(PlayerEvent.SHOW_AVAILBLE, onShowAvailble);
		}
		
		private function onShowAvailble(e:PlayerEvent):void
		{
			trace('show');
		}
	}
}