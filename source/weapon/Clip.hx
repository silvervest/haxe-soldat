package weapon;

import flixel.group.FlxTypedGroup;
import weapon.Bullet;

class Clip extends FlxTypedGroup<Bullet>
{
    private var rounds:Int = 30;
    private var spent:Int = 0;

    public function new(Rounds:Int)
    {
        super(Rounds);
        rounds = Rounds;

        load();
    }
	
	public function load()
	{
        for (i in 0...rounds) {
            var bullet = new Bullet(this);
            add(bullet);
			Reg.bulletLayer.add(bullet);
        }
	}

    public function reload()
    {
		spent = 0;
    }

    public function isEmpty():Bool
    {
        return (spent == rounds);
    }
	
	override public function update():Void
	{
		super.update();
		
		// ask each alive bullet to update, checks for lifespan
		//forEachAlive(function(bullet:Bullet):Void {
			//bullet.update();
		//}
	}

}