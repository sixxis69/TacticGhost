package tacticghost
{
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Pivot3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Game extends Sprite
	{
		private var gameContainer:Sprite;
		private var controlContainer:Sprite;
		
		private var scene:GameScene;
		private var mapContainer:Pivot3D;
		
		public function Game()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,active);
		}
		
		private function active(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,active);
			
			initGame();
			initControl();
		}
		
		private function initGame():void
		{
			scene = new GameScene(this);
			scene.stage = this.stage;
			scene.camera.setPosition(0,1500,-1500);
			scene.camera.lookAt(0,0,0);
			
			mapContainer = new Pivot3D('map');
			scene.addChild(mapContainer);
		}
		
		private function initControl():void
		{
			// TOD: create ui control
//			var spr:Sprite = new Sprite();
//			spr.add
		}
		
		public function addMap(map:Pivot3D):void
		{
			scene.addChild(map);
		}
	}
}