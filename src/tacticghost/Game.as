package tacticghost
{
	import flare.basic.Scene3D;
	import flare.core.Pivot3D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tacticghost.maps.core.MapTemplate;
	import tacticghost.ui.core.iPhoneController;
	import tacticghost.ui.events.ControllerEvent;
	
	public class Game extends Sprite
	{
		private var gameContainer:Sprite;
		private var controllerPad:iPhoneController;
		
		private var scene:GameScene;
		private var mapContainer:MapTemplate;
		
		public function Game()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,active);
			this.addEventListener(Event.REMOVED_FROM_STAGE,deactive);
		}
		
		private function active(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,active);
			
			initGame();
			initControl();
		}
		
		private function deactive(e:Event):void
		{
			
		}
		
		private function initGame():void
		{
			gameContainer = new Sprite();
			this.addChild(gameContainer);
			
			scene = new GameScene(gameContainer);
			scene.stage = this.stage;
			scene.camera.setPosition(0,200,-200);
			scene.camera.lookAt(0,0,0);
			
			scene.addEventListener(Scene3D.UPDATE_EVENT, updateHandler);
		}
		
		private function initControl():void
		{
			controllerPad = new iPhoneController();
			controllerPad.addEventListener(ControllerEvent.CLICK, controllerHandler);
			this.addChild(controllerPad);
		}
		
		private function controllerHandler(e:ControllerEvent):void
		{
			switch(e.clickType)
			{
				case iPhoneController.UP:
					mapContainer.moveCursor(0,-1);
					break;
				case iPhoneController.DOWN:
					mapContainer.moveCursor(0,1);
					break;
				case iPhoneController.LEFT:
					mapContainer.moveCursor(-1,0);
					break;
				case iPhoneController.RIGHT:
					mapContainer.moveCursor(1,0);
					break;
				case iPhoneController.ACTION:
					mapContainer.openAction();
					break;
			}
		}
		
		public function addMap(map:MapTemplate):void
		{
			mapContainer = map;
			scene.addChild(mapContainer);
		}
		
		private function updateHandler(e:Event):void
		{
			mapContainer.update();
		}
	}
}