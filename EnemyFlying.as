package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.motion.Color;
	
	
	public class EnemyFlying extends MovieClip {
		public var healthUnChecked:Boolean = true;
		public var Lvl:int = 1;
		public var playerDam:int = 30 + Math.random()*50;
		public var playerX:int = 0;
		public var XP:int = 60;
		public var Power:Timer=new Timer(2000);
		public var speed:int = 4;
		public var time:int = 0;
		public var stunTimer:Timer=new Timer(time);
		public var damageOverTime:int = 0;
		private var c:Color = new Color;
		public var damageOverTimeTimer:Timer=new Timer(1000, 5);
		public var DOT:Boolean = false;
		public var yLoc:int = 0;
		public var xLoc:int = 0;
		public var health:int=150 + Math.random()*50;
		public var counter:int = 24;
		public var reSpawnTimer:Timer=new Timer(10000);
		public function EnemyFlying(xLocation:int, yLocation:int) {
			x = xLocation;
			y = yLocation;
			xLoc = x;
			yLoc = y;
			addEventListener(Event.ENTER_FRAME, everyFrame);
			
		}
		public function powerShot(damage:int):void{
			var colour:uint=0xFFFF99;
			c.setTint(colour,0.4);
			this.transform.colorTransform=c;
			Power.start();
			Power.addEventListener(TimerEvent.TIMER, stopDOT);
			takeDamage(damage);
		}
		private function getHealth ():void {
			if (healthUnChecked) {
			health = health * Lvl;
			healthUnChecked = false;
			
			}
		}
		public function getStunned(timer:int){
			trace ("la");
			time = timer;
			stunTimer = new Timer(time);
			stunTimer.start();
			stunTimer.addEventListener(TimerEvent.TIMER, unStun);
			speed = 0;
			var colour:uint=0x0099FF;
			c.setTint(colour,0.4);
			this.transform.colorTransform=c;
			removeEventListener(Event.ENTER_FRAME, everyFrame);
		}
		public function unStun (e:TimerEvent){
			stunTimer.removeEventListener(TimerEvent.TIMER, unStun);
			stunTimer.stop();
			speed = 4;
			var colour:uint=0xFF6600;
			c.setTint(colour,0.0);
			this.transform.colorTransform=c;
			addEventListener(Event.ENTER_FRAME, everyFrame);

		}
		public function takeDOT(damageOT:int, damage:int) {
			damageOverTimeTimer=new Timer(1000, 5);
			damageOverTime = damageOT;
			trace ("DOT has begun");
			damageOverTimeTimer.start();
			damageOverTimeTimer.addEventListener(TimerEvent.TIMER, transDOT);
			damageOverTimeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, stopDOT);
			var colour:uint=0xFF6600;
			c.setTint(colour,0.4);
			this.transform.colorTransform=c;
			takeDamage(damage);
		}
		public function stopDOT(e:TimerEvent){
			damageOverTimeTimer.stop();
			Power.stop();
			var colour:uint=0xFF6600;
			c.setTint(colour,0);
			this.transform.colorTransform=c;
		}
		public function everyFrame(e:Event){
			
			counter -= 1;
			playerDam = (15 + Math.random()*10)*Lvl
			if (counter > 0) {
			x -= speed;
			scaleX = 1;
			getHealth();
			}
			if (counter < 0) {
				x += speed;
				scaleX = -1;
			}
			if (counter == -25) {
				counter += 51;
			}
		}
		public function transDOT (e:TimerEvent){
			takeDamage(damageOverTime);
		}
		public function takeDamage(damage:int){
			health -= damage;
			if (health <=0) {
				removeSelf();
				XP = 60 + Lvl*40;
			}
			trace("health:"+health);
		}
		public function die():void{
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			this.parent.removeChild(this);
		}
		public function removeSelf ():void {
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			this.visible = false;
			this.x -= 50000;
			reSpawnTimer.start();
			reSpawnTimer.addEventListener(TimerEvent.TIMER, respawn);
		}
			public function respawn (e:TimerEvent):void{
			health = 150 + Math.random()*50;
			addEventListener(Event.ENTER_FRAME, everyFrame);
			reSpawnTimer.stop();
			reSpawnTimer.removeEventListener(TimerEvent.TIMER, respawn);
			this.visible = true;
			this.x += 50000;
			x = xLoc;
			y = yLoc;
			healthUnChecked = true;
		}
	}
}
