package tacticghost.maps
{
	import flare.basic.Scene3D;
	import flare.core.Pivot3D;
	import flare.loaders.ColladaLoader;
	import flare.loaders.Flare3DLoader2;
	
	import flash.events.Event;
	
	import tacticghost.maps.core.MapTemplate;
	
	public class Map1 extends MapTemplate
	{
		private var fldr:Flare3DLoader2;
		private var model:Pivot3D;
		
		public function Map1(name:String="")
		{
			super(name);
			
			loadModel();
			createGrid(20,20);
			grid.setWalkable(10,9,false);
			grid.setWalkable(13,9,false);
			grid.setWalkable(14,9,false);
		}
		
		override protected function loadModel():void
		{
			fldr=new Flare3DLoader2("assets/maps/dummy_map.f3d");
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