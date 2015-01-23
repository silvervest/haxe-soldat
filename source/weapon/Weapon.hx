package weapon;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.FlxAccelerometer;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxTypedGroup;
import weapon.Clip;
import Player;
import Reg;

class Weapon extends FlxSprite
{
    private var parent:Player;
    private var numBullets:Int = 30;
    private var magazine:Clip;
	private var fireRate:Float = 0.05; // this must be >= bullet.lifespan / numBullets, or it'll crash
	private var firing:Float = 0;

    public function new(Parent:Player)
    {
        parent = Parent;
        super(0,0); // this should be the Player's X,Y offset by some amount

        makeGraphic(6, 2, FlxColor.BLUE);
		
		magazine = new Clip(numBullets);
    }
	
	public function fire()
	{
		var spareBullet = magazine.getFirstAvailable();
		spareBullet.fire(parent.x, parent.y);
		firing = fireRate;
	}
	
	public function isFiring():Bool
	{
		return (firing > 0);
	}

    override public function update():Void
    {
        // we should offset these as well
        x = parent.x;
        y = parent.y;
		
		if (firing > 0) {
			firing -= FlxG.elapsed;
		}

        super.update();
    }
}