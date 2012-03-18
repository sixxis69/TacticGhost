package tacticghost.player.core
{
	import com.bit101.components.PushButton;
	
	import flare.core.Boundings3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	import flare.events.MouseEvent3D;
	import flare.loaders.ColladaLoader;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.primitives.Cube;
	import flare.utils.Mesh3DUtils;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import tacticghost.GameScene;
	import tacticghost.player.events.PlayerEvent;
	
	public class PlayerTemplate extends Pivot3D
	{
		[Embed(source='assets/player.dae',mimeType='application/octet-stream')]
		private var DAEFile:Class
		
		private var isClick:Boolean;
		private var bt:PushButton;
		
		// TODO: template walk
		private var _walk:Vector.<Vector.<int>> = new <Vector.<int>>[
			new <int>[0,1,0],
			new <int>[0,1,0],
			new <int>[0,2,0]];
		
		public function PlayerTemplate(name:String="")
		{
			super(name);
			
			loadModel();
		}
		
		protected function loadModel():void
		{
			// load
			var modelLoader:ColladaLoader = new ColladaLoader(XML(new DAEFile()),this,null,'assets/');
			modelLoader.load();

			// convert to mesh
			var obj:Mesh3D = Mesh3DUtils.merge(this.children);
			obj.y = 50;
			this.addChild(obj);
			
			// add event
			obj.addEventListener(MouseEvent3D.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent3D):void
		{
			if(!isClick)
			{
				var s:Stage = GameScene(this.scene).stage;
				bt = new PushButton(s,s.mouseX+10,s.mouseY-30,'walk');
				bt.addEventListener(MouseEvent.CLICK, onClickButton);
				
				isClick = true;
			}
		}
		
		private function onClickButton(e:MouseEvent):void
		{
			isClick = false;
			bt.removeEventListener(MouseEvent.CLICK, onClickButton);
			bt.parent.removeChild(bt);
			
			this.dispatchEvent(new PlayerEvent(PlayerEvent.SHOW_AVAILBLE));
		}
	}
}