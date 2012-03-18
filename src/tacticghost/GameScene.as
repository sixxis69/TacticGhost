package tacticghost
{
	import flare.basic.Viewer3D;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	// TODO: change to scene3d when publish
	public class GameScene extends Viewer3D
	{
		public var stage:Stage;
		public function GameScene(container:DisplayObjectContainer, file:String="")
		{
			super(container, file);
		}
	}
}