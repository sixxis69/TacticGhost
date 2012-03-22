package tacticghost.ui.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import tacticghost.ui.events.ControllerEvent;
	
	public class iPhoneController extends ControllerDesign
	{
		public static const UP:String 		= "up";
		public static const DOWN:String		= "down";
		public static const LEFT:String		= "left";
		public static const RIGHT:String	= "right";
		public static const ACTION:String	= "action";
		
		public function iPhoneController()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,active);
			this.addEventListener(Event.REMOVED_FROM_STAGE,deactive);
		}
		
		private function active(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,active);
			
			upBt.addEventListener(MouseEvent.CLICK, clickHandler);
			downBt.addEventListener(MouseEvent.CLICK, clickHandler);
			leftBt.addEventListener(MouseEvent.CLICK, clickHandler);
			rightBt.addEventListener(MouseEvent.CLICK, clickHandler);
			actionButton.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function deactive(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,deactive);
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			switch(e.currentTarget)
			{
				case upBt:
					this.dispatchEvent(new ControllerEvent(ControllerEvent.CLICK,UP));
					break;
				case downBt:
					this.dispatchEvent(new ControllerEvent(ControllerEvent.CLICK,DOWN));
					break;
				case leftBt:
					this.dispatchEvent(new ControllerEvent(ControllerEvent.CLICK,LEFT));
					break;
				case rightBt:
					this.dispatchEvent(new ControllerEvent(ControllerEvent.CLICK,RIGHT));
					break;
				case actionButton:
					this.dispatchEvent(new ControllerEvent(ControllerEvent.CLICK,ACTION));
					break;
			}
		}
	}
}