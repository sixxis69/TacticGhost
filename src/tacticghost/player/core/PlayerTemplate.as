package tacticghost.player.core
{
	import flare.basic.Scene3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.events.MouseEvent3D;
	import flare.loaders.ColladaLoader;
	import flare.loaders.Flare3DLoader2;
	import flare.utils.Mesh3DUtils;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import tacticghost.GameScene;
	import tacticghost.maps.core.Node;
	import tacticghost.player.events.PlayerEvent;
	
	public class PlayerTemplate extends Pivot3D
	{
		private var isClick:Boolean;
		private var fldr:Flare3DLoader2;
		private var model:Pivot3D;
		
		public static const WALK:int = 1;
		public static const PLAYER:int = 2;
		
		protected var walkList:Vector.<Vector.<int>> = new <Vector.<int>>[
			new <int>[0,1,0,1,0],
			new <int>[1,0,0,0,1],
			new <int>[0,0,2,0,0],
			new <int>[1,0,0,0,1],
			new <int>[0,1,0,1,0]];
		
		public function getWalkNode(nx:int,nz:int):Vector.<Node>
		{
			var result:Vector.<Node> = new Vector.<Node>();
			var userNode:Node;
			
			var i:int;
			var j:int;
			var n:Node;
			
			// find node
			for(i=0; i<walkList.length; i++)
			{
				for(j=0; j<walkList[i].length; j++)
				{
					switch(walkList[i][j])
					{
						case 1:
							n = new Node(j,i);
							result.push(n);
							break;
						case 2:
							userNode = new Node(j,i);
							break;
					}
				}
			}
			
			// compare with map
			var difNode:Node = new Node(userNode.x-nx,userNode.z-nz);
			for(i=0; i<result.length; i++)
			{
				result[i].x = result[i].x - difNode.x;
				result[i].z = result[i].z - difNode.z;
			}
			
			return result;
		}
		
		public function walk(list:Vector.<Node>):void
		{
			trace('move player');
			
		}
		
		public function PlayerTemplate(name:String="")
		{
			super(name);
			
			loadModel();
		}
		
		protected function loadModel():void
		{
			fldr=new Flare3DLoader2("assets/players/player.f3d");
			fldr.load()
			fldr.addEventListener(Scene3D.COMPLETE_EVENT,onComplete);
		}
		
		private function onComplete(e:Event):void{
			model=Pivot3D(fldr.clone());
			model.setScale(1,1,1);
			this.addChild(model);
		}
	}
}