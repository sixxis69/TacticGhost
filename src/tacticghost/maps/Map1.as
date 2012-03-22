package tacticghost.maps
{
	import tacticghost.maps.core.MapTemplate;
	import flare.loaders.ColladaLoader;
	
	public class Map1 extends MapTemplate
	{
		[Embed(source='assets/maps/dummy_map.dae',mimeType='application/octet-stream')]
		private var DAEFile:Class
		
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
			// load
			var modelLoader:ColladaLoader = new ColladaLoader(XML(new DAEFile()),this,null,'assets/maps/');
			modelLoader.load();
		}
	}
}