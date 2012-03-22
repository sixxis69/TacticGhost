package tacticghost.maps.core
{
	import flare.basic.Scene3D;
	import flare.core.Pivot3D;
	import flare.core.Texture3D;
	import flare.materials.Material3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.AnimatedTextureFilter;
	import flare.primitives.Plane;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CursorPlane extends Plane
	{
		private static const IMG_PATH:String = 'assets/cursor.png'
		private var animFilter:AnimatedTextureFilter;
		private var xml:XML = 
			<data>
				<sprite id= 'spr01' x ='0' y='0' width='100' height='100'/>
				<sprite id= 'spr02' x ='100' y='0' width='100' height='100'/>
				<sprite id= 'spr03' x ='200' y='0' width='100' height='100'/>
				<sprite id= 'spr04' x ='300' y='0' width='100' height='100'/>
				<sprite id= 'spr05' x ='400' y='0' width='100' height='100'/>
				<sprite id= 'spr06' x ='500' y='0' width='100' height='100'/>
				<sprite id= 'spr07' x ='600' y='0' width='100' height='100'/>
				<sprite id= 'spr08' x ='700' y='0' width='100' height='100'/>
				<sprite id= 'spr09' x ='800' y='0' width='100' height='100'/>
				<sprite id= 'spr10' x ='900' y='0' width='100' height='100'/>
				<sprite id= 'spr11' x ='0' y='100' width='100' height='100'/>
				<sprite id= 'spr12' x ='100' y='100' width='100' height='100'/>
				<sprite id= 'spr13' x ='200' y='100' width='100' height='100'/>
				<sprite id= 'spr14' x ='300' y='100' width='100' height='100'/>
				<sprite id= 'spr15' x ='400' y='100' width='100' height='100'/>
				<sprite id= 'spr16' x ='500' y='100' width='100' height='100'/>
				<sprite id= 'spr17' x ='600' y='100' width='100' height='100'/>
				<sprite id= 'spr18' x ='700' y='100' width='100' height='100'/>
				<sprite id= 'spr19' x ='800' y='100' width='100' height='100'/>
				<sprite id= 'spr20' x ='900' y='100' width='100' height='100'/>
				<sprite id= 'spr21' x ='0' y='200' width='100' height='100'/>
				<sprite id= 'spr22' x ='100' y='200' width='100' height='100'/>
				<sprite id= 'spr23' x ='200' y='200' width='100' height='100'/>
				<sprite id= 'spr24' x ='300' y='200' width='100' height='100'/>
				<sprite id= 'spr25' x ='400' y='200' width='100' height='100'/>
				<sprite id= 'spr26' x ='500' y='200' width='100' height='100'/>
				<sprite id= 'spr27' x ='600' y='200' width='100' height='100'/>
				<sprite id= 'spr28' x ='700' y='200' width='100' height='100'/>
				<sprite id= 'spr29' x ='800' y='200' width='100' height='100'/>
				<sprite id= 'spr30' x ='900' y='200' width='100' height='100'/>
				<sprite id= 'spr31' x ='0' y='300' width='100' height='100'/>
				<sprite id= 'spr32' x ='100' y='300' width='100' height='100'/>
				<sprite id= 'spr33' x ='200' y='300' width='100' height='100'/>
				<sprite id= 'spr34' x ='300' y='300' width='100' height='100'/>
				<sprite id= 'spr35' x ='400' y='300' width='100' height='100'/>
				<sprite id= 'spr36' x ='500' y='300' width='100' height='100'/>
				<sprite id= 'spr37' x ='600' y='300' width='100' height='100'/>
				<sprite id= 'spr38' x ='700' y='300' width='100' height='100'/>
				<sprite id= 'spr39' x ='800' y='300' width='100' height='100'/>
				<sprite id= 'spr40' x ='900' y='300' width='100' height='100'/>
				<sprite id= 'spr41' x ='0' y='400' width='100' height='100'/>
				<sprite id= 'spr42' x ='100' y='400' width='100' height='100'/>
				<sprite id= 'spr43' x ='200' y='400' width='100' height='100'/>
				<sprite id= 'spr44' x ='300' y='400' width='100' height='100'/>
				<sprite id= 'spr45' x ='400' y='400' width='100' height='100'/>
				<sprite id= 'spr46' x ='500' y='400' width='100' height='100'/>
				<sprite id= 'spr47' x ='600' y='400' width='100' height='100'/>
				<sprite id= 'spr48' x ='700' y='400' width='100' height='100'/>
				<sprite id= 'spr49' x ='800' y='400' width='100' height='100'/>
				<sprite id= 'spr50' x ='900' y='400' width='100' height='100'/>
				<sprite id= 'spr51' x ='0' y='500' width='100' height='100'/>
			</data>
		
		public function CursorPlane(name:String="", width:Number=10, height:Number=10, segments:int=1, material:Material3D=null, axis:String="+xz")
		{
			this.addEventListener(Pivot3D.ADDED_TO_SCENE_EVENT, active);
			
			super(name, width, height, segments, material, axis);
		}
		
		private function active(e:Event):void
		{
			this.removeEventListener(Pivot3D.ADDED_TO_SCENE_EVENT, active);
			
			var texture3D:Texture3D = scene.addTextureFromFile(IMG_PATH);
			var tWidth:int = 1024;
			var tHeight:int = 1024;
			
			animFilter = new AnimatedTextureFilter(texture3D);
			for each(var data:XML in xml.children())
			{
				animFilter.addFrame(data.@x/tWidth,data.@y/tHeight,data.@width/tWidth,data.@height/tHeight);
			}
			
			var mat:Shader3D = new Shader3D('',[animFilter]);
			
			setMaterial(mat);
			
			this.y = 0.5;
		}
		
		public function updateAnimate():void
		{
			animFilter.currentFrame++;
		}
		
	}
}