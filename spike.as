package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.motion.Color;
	
	
	public class spike extends MovieClip {
		public var Lvl: int = 1;
		public var playerDam = (30 + Math.random()*15);
		public var XP:int = 50;
		public var speed:int = 4;
		public var playerX:int = 0;
		var time:int = 0;
		var stunTimer:Timer=new Timer(time);
		public var damageOverTime:int = 0;
		private var c:Color = new Color;
		public var damageOverTimeTimer:Timer=new Timer(1000, 5);
		public var DOT:Boolean = false;
		public var yLoc:int = 0;
		public var xLoc:int = 0;
		public var health:int=100 + Math.random()*50;
		public var counter:int = 24;
		public var reSpawnTimer:Timer=new Timer(10000);
		public function spike(xLocation:int, yLocation:int) {
			x = xLocation;
			y = yLocation;
			xLoc = x;
			yLoc = y;
			addEventListener(Event.ENTER_FRAME, everyFrame);
		}
		public function powerShot(damage:int):void {
			
		}
		public function getStunned(timer:int){
			
		}
		
		public function takeDOT(damageOT:int, damage:int) {
			
		}
		
		public function everyFrame(e:Event){
			playerDam = (15 + Math.random()*10)*Lvl
		}
		public function die():void{
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			this.parent.removeChild(this);
		}
		
		public function takeDamage(damage:int){
			health = damage;
			if (health <=0) {
				removeSelf();
			}
			trace("health:"+health);
		}
		public function removeSelf ():void {
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			this.visible = false;
			this.x -= 50000;
			reSpawnTimer.start();
			reSpawnTimer.addEventListener(TimerEvent.TIMER, respawn);
		}
		public function respawn (e:TimerEvent):void{
			health = 100 + Math.random()*50;
			addEventListener(Event.ENTER_FRAME, everyFrame);
			reSpawnTimer.stop();
			reSpawnTimer.removeEventListener(TimerEvent.TIMER, respawn);
			this.visible = true;
			this.x += 50000;
			x = xLoc;
			y = yLoc;
		}
	}
}