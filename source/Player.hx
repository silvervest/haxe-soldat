package ;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import Math;
import weapon.Weapon;
import Reg;

class Player extends FlxSprite
{
	private var parent:PlayState;
	private var weapon:Weapon;
	
	private var ACCELERATION:Int = 600;
	private var MAX_SPEED:Int = 300;
	private var JUMP_SPEED:Int = -400; // negative in y is up!
	private var DRAG:Int = 900;
	private var GRAVITY:Int = 960;
	
	private var onGround:Bool;
	
	public function new(X:Float=0, Y:Float=0, Parent:PlayState) 
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.RED);

		drag.x = DRAG;
		maxVelocity.x = MAX_SPEED;
		maxVelocity.y = MAX_SPEED * 6;
		width = 8;
		height = 14;
		offset.x = 4;
		offset.y = 2;
		acceleration.y = GRAVITY;
				
		parent = Parent;

		weapon = new Weapon(this);
		Reg.weaponLayer.add(weapon);
	}
	
	override public function draw():Void 
	{
		super.draw();
	}
	
	private function movement():Void
	{
		onGround = isTouching(FlxObject.FLOOR);
		var speedFactor:Float = 1;
		
		// Handle jumps
		if (FlxG.keys.anyPressed(["UP", "W", "SPACE"]) && onGround) {
			velocity.y = JUMP_SPEED; 
		}
		
		// accelerate faster if we're moving in the opposite direction
		if (velocity.x != 0) {
			speedFactor = 6;
		} else {
			speedFactor = 1;
		}

		// Handle left/right presses
		if (FlxG.keys.anyPressed(["LEFT", "A"])) {
			acceleration.x = -ACCELERATION * speedFactor;
		} else if (FlxG.keys.anyPressed(["RIGHT", "D"])) {
			acceleration.x = ACCELERATION * speedFactor;
		} else {
			acceleration.x = 0;
		}
		
		// Camera zoom based on current velocity
		// NewValue = (((OldValue - OldMin) * (NewMax - NewMin)) / (OldMax - OldMin)) + NewMin
		//var cameraZoom:Float = (((Math.max(Math.abs(velocity.x), Math.abs(velocity.y)) - 0) * (0.8 - 1)) / (MAX_SPEED - 0)) + 1;
		//FlxG.camera.zoom = cameraZoom;
		
		// Wrap around the map
		if (x <= 0) {
			//x = parent.map.width - width;
			x = 0;
		}
		if ((x + width) > parent.map.width) {
			//x = 0;
			x = parent.map.width - width;
		}
	}
	
	public function combat():Void
	{
		if (FlxG.mouse.pressed && !weapon.isFiring()) {
			weapon.fire();
		}
	}
	
	override public function update():Void 
	{
		movement();
		combat();
		super.update();
	}

	public function getWeapon():Weapon
	{
		return weapon;
	}
}