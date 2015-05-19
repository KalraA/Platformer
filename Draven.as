package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.motion.Color;
	
	
	public class Draven extends MovieClip {
		public var healthUnChecked:Boolean = true;
		public var Lvl:int = 1;
		public var facing:String = 'left'; 
		public var playerDam = 80 + Math.random()*30;
		public var XP:int = 1000;
		var time:int = 0;
		var stunTimer:Timer=new Timer(time);
		public var damageOverTime:int = 0;
		private var c:Color = new Color;
		public var damageOverTimeTimer:Timer=new Timer(1000, 5);
		public var Power:Timer=new Timer(2000);
		public var DOT:Boolean = false;
		public var yLoc:int = 0;
		public var xLoc:int = 0;
		public var health:int=1000 + Math.random()*500;
		public var counter:int = 24;
		public var reSpawnTimer:Timer=new Timer(10000);
		// attacks
		public var checkTimer:Timer=new Timer (2000);
		public var checker:Number = 0;
		public var diving:Boolean=false;
		public var jumping:Boolean=false;
		public var smashing:Boolean=false;
		public var xSpeed:Number=0;
		public var ySpeed:Number=0;
		public var friction:Number= 0.98;
		public var gravity:Number= 1.5;
		public var animationState:String = 'idle';
		public var playerX:int = 0;
		public function Draven(xLocation:int, yLocation:int) {
			this.x = xLocation;
			y = yLocation;
			xLoc = x;
			yLoc = y;
			addEventListener(Event.ENTER_FRAME, everyFrame);
			checkTimer.start();
			checkTimer.addEventListener(TimerEvent.TIMER, checkWhatToDo);
		}
		public function die():void {
			removeSelf();
		}
		public function getStunned(timer:int){
			trace ("la");
			time = timer;
			stunTimer = new Timer(time);
			stunTimer.start();
			stunTimer.addEventListener(TimerEvent.TIMER, unStun);
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			var colour:uint=0x0099FF;
			c.setTint(colour,0.4);
			this.transform.colorTransform=c;
			checkTimer.stop();
		}
		public function unStun (e:TimerEvent){
			stunTimer.removeEventListener(TimerEvent.TIMER, unStun);
			stunTimer.stop();
			checkTimer.start();
			var colour:uint=0xFF6600;
			c.setTint(colour,0.0);
			this.transform.colorTransform=c;
			if (health > 0) {
			addEventListener(Event.ENTER_FRAME, everyFrame);
			}
		}
		public function takeDOT(damageOT:int, damage:int) {
			
		}
		
		public function checkWhatToDo(e:TimerEvent){
			trace("im checking");
			checker = Math.random();
			diving = false;
			jumping = false;
			xSpeed = 0;
			if (checker > 0.5) {
				diving = true;
			}
			if (checker < 0.5) {
				jumping = true;
			}
			getHealth();
		}
		private function getHealth ():void {
			if (healthUnChecked) {
			health = health * Lvl;
			healthUnChecked = false;
			}
		}
		public function everyFrame(e:Event){
			trace (xSpeed)
			trace (ySpeed)
			this.x += xSpeed;
			this.y += ySpeed;
			ySpeed += gravity;
			ySpeed *= friction;
			xSpeed *= friction;
			if (xSpeed > 20) {
				xSpeed = 20;
			}
			if (ySpeed > 20) {
				ySpeed = 20;
			}
			if (jumping) {
				if (scaleX == 1) {
				xSpeed += 10;
				} else {
					xSpeed -= 10
				}
				ySpeed -= 20;
				jumping = false;
				gravity = 1.5;
				
			}
			if (diving) {
				if (scaleX == 1) {
				xSpeed += 30;
				} else {
					xSpeed -= 30;
				}
				diving = false;
			}
			if (y > 0) {
				y = 0;
				ySpeed = 0;
				gravity = 0;
				jumping = false;
			}
			if (y < - 600) {
				y = -y*0.1;
			}
			if (this.currentFrameLabel != animationState){
				this.gotoAndStop(animationState);
			}
			trace (animationState);
			if (ySpeed < 0) {
				animationState = "uppercut";
			} else if (ySpeed > 0) {
				animationState = "smash";
			} else if (xSpeed != 0) {
				animationState = "dive";
			} else {
				animationState = "idle";
			}
			if (this.x > 470) {
				xSpeed *= -1;
				scaleX = -1;
				this.x -= 50;
			} else if (this.x < 50) {
				xSpeed *= -1;
				scaleX = 1;
				this.x += 50;
			}
			trace (scaleX);
			playerDam = (100 + Math.random()*30)*(Lvl/3);
		}
		public function transDOT (e:TimerEvent){
			takeDamage(damageOverTime);
		}
		public function takeDamage(damage:int){
			health -= damage;
			if (health <=0) {
				removeSelf();
			}
		}
		public function powerShot (damage:int) {
			
		}
		public function removeSelf():void{
			removeEventListener(Event.ENTER_FRAME, everyFrame);
			
			this.parent.removeChild(this);
		}
	}
}
