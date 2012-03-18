package tacticghost.maps
{
	import tacticghost.maps.core.MapTemplate;
	
	public class Map1 extends MapTemplate
	{
		public function Map1(name:String="")
		{
			super(name);
		}
		
		override protected function createObject():void
		{
			super.createObject();
				
			createDummy(1,1);
			createDummy(2,2);
			createDummy(3,3);
			createDummy(4,4);
		}
		
	}
}