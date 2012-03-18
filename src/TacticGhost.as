package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import tacticghost.Game;
	import tacticghost.maps.Map1;
	import tacticghost.maps.core.MapTemplate;
	import tacticghost.player.core.PlayerTemplate;
	
	[SWF(backgroundColor=0xffffff,width=960,height=640,frameRate=60)]
	public class TacticGhost extends Sprite
	{
		private var game:Game;
		
		public function TacticGhost()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, active);
		}
		
		private function active(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, active);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			
			game = new Game();
			this.addChild(game);
			
			var m:MapTemplate = new Map1();
			game.addMap(m);
			
			var p:PlayerTemplate = new PlayerTemplate();
			m.addPlayer(p,0,0);
		}
	}
}