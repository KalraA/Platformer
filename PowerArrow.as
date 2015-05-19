package  {
	//imports
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class PowerArrow extends MovieClip {
		public var speed:int = 60;//this is the speed of the PowerArrow
		private var initialX:int;//the initial xlocation of the PowerArrow
		public function PowerArrow(playerX:int, playerY:int, playerDirection:String, playerSpeed:Number) {//when this funciton runs, you need to feed it 4 numbers for it to run
			if (playerDirection == "left") {//if the player is facing left then...
				speed = -speed+playerSpeed;//the speed of the PowerArrow is 30 + the speed of the player (so he cant run after his PowerArrow)
				x=playerX - 35;//the xlocation of the PowerArrow is where the player is - 35 pixels
				this.scaleX *= -1;//flip te PowerArrow so it faces left
			} else if(playerDirection == "right") {
				speed = speed+playerSpeed;//the speed of the PowerArrow is 30 + the speed of the player (so he cant run after his PowerArrow)
				x = playerX + 35;//the xlocation of the PowerArrow is where the player is + 35 pixels
			}
			y = playerY - 75;//the ylocating is player's y loction - 75 pixes, so 75 pixels higher than the players location
			addEventListener(Event.ENTER_FRAME, everyFrame);//everyframe execute the stuff in the everyframe function
			initialX = x;//the initialX location equals the x location
		}
		
		public function everyFrame (e:Event):void {// stuff that should happen everyframe
			x += speed;//move the x point by the speed
			if(speed > 0) {//if the PowerArrow is going to the right then
    			if(x > initialX + 1500) { //after 640 pixeels of travel time
        		removeSelf();//remove it (by calling on the removeSelf function)
    			}
			} else {
    			if(x < initialX - 1500) {  //after 640 pixeels of travel time
        		removeSelf();//remove it (call on the removeSelf function)
    			}
			}
		}
		public function removeSelf ():void {//how to remove itself
			removeEventListener(Event.ENTER_FRAME, everyFrame);//take away the eventListener that tells it to execute the function everyFrame on every frame
			this.parent.removeChild(this);
			trace ("IM DYING");//remove itself
		}
	}
}