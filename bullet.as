package  {
	//imports
	import flash.events.Event;
	import flash.display.MovieClip;
	
	
	public class bullet extends MovieClip {
		public var speed:int = 30;//this is the speed of the bullet
		private var initialX:int;//the initial xlocation of the bullet
		public function bullet(playerX:int, playerY:int, playerDirection:String, playerSpeed:Number) {//when this funciton runs, you need to feed it 4 numbers for it to run
			trace (playerX + " " + playerY + " " + playerDirection + " " + playerSpeed);
			if (playerDirection == "left") {//if the player is facing left then...
				speed = -speed+playerSpeed;//the speed of the bullet is 30 + the speed of the player (so he cant run after his bullet)
				x=playerX - 35;//the xlocation of the bullet is where the player is - 35 pixels
				this.scaleX *= -1;//flip te bullet so it faces left
			} else if(playerDirection == "right") {
				speed = speed+playerSpeed;//the speed of the bullet is 30 + the speed of the player (so he cant run after his bullet)
				x = playerX + 35;//the xlocation of the bullet is where the player is + 35 pixels
			}
			y = playerY - 75;//the ylocating is player's y loction - 75 pixes, so 75 pixels higher than the players location
			addEventListener(Event.ENTER_FRAME, everyFrame);//everyframe execute the stuff in the everyframe function
			initialX = x;//the initialX location equals the x location
		}
		
		public function everyFrame (e:Event):void {// stuff that should happen everyframe
			x += speed;//move the x point by the speed
			if(speed > 0) {//if the bullet is going to the right then
    			if(x > initialX + 640) { //after 640 pixeels of travel time
        		removeSelf();//remove it (by calling on the removeSelf function)
    			}
			} else {
    			if(x < initialX - 640) {  //after 640 pixeels of travel time
        		removeSelf();//remove it (call on the removeSelf function)
    			}
			}
		}
		public function removeSelf ():void {//how to remove itself
			removeEventListener(Event.ENTER_FRAME, everyFrame);//take away the eventListener that tells it to execute the function everyFrame on every frame
			this.parent.removeChild(this);//remove itself
		}
	}
}


