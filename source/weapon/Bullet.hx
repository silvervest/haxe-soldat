package weapon;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxVelocity;
import flixel.util.FlxRandom;
import flixel.util.FlxPoint;
import weapon.Clip;

class Bullet extends FlxSprite
{
    private var parent:Clip;
	private var damage:Int;
	private var speed:Int = 800; // not too fast, or the bullets will move so fast per frame that collisions might not happen!
	private var lifespan:Float = 0.7; // seconds
	private var age:Float = 0; // how old this bullet is once fired

    public function new(Parent:Clip)
    {
        parent = Parent;

        super(0, 0);
        makeGraphic(2, 2, FlxColor.WHITE);
		
		kill(); // start off dead
    }
	
	public function fire(fromX:Float, fromY:Float)
	{
		// just implement some randomness
		x = fromX + FlxRandom.floatRanged(-5, 5);
		y = fromY + FlxRandom.floatRanged( -5, 5);
		
		revive();
		age = lifespan;
		FlxVelocity.moveTowardsMouse(this, speed);
	}

	override public function update():Void
	{
		super.update();

		// kill old bullets
		if (age > 0) {
			age -= FlxG.elapsed;
			
			if (age <= 0) {
				kill();
			}
		}
		
		// kill off-screen bullets

		// Bullet off the top of the screen?
		//if (exists && y < -height) {
			//exists = false;
		//}
	}
}