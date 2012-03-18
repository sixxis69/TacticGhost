package tacticghost.player.events
{
	import flash.events.Event;
	
	public class PlayerEvent extends Event
	{
		public static const SHOW_AVAILBLE:String	= 'PlayerEventShowAvailble';
		
		public function PlayerEvent(type:String)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new PlayerEvent(type);
		}
		
	}
}