package tacticghost.ui.events
{
	import flash.events.Event;
	
	public class ControllerEvent extends Event
	{
		public static const CLICK:String	= "ControllerEventClick";
		
		public var clickType:String;
		
		public function ControllerEvent(type:String,cType:String)
		{
			clickType = cType;
			super(type);
		}
		
		override public function clone():Event
		{
			return new ControllerEvent(type,clickType);
		}
		
	}
}