package;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import Reg;
import weapon.Bullet;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var map:FlxOgmoLoader;
	private var walls:FlxTilemap;
	private var player:Player;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		map = new FlxOgmoLoader("assets/data/open-air.oel");
		walls = map.loadTilemap("assets/images/rogueliketiles.png", 16, 16, "walls");
		walls.setTileProperties(15, FlxObject.ANY);
		walls.setTileProperties(8, FlxObject.ANY);
		add(walls);

		Reg.playerLayer = new FlxGroup();
		Reg.weaponLayer = new FlxGroup();
		Reg.bulletLayer = new FlxGroup();
		
		add(Reg.playerLayer);
		add(Reg.weaponLayer);
		add(Reg.bulletLayer);

		player = new Player(16, 16, this);
		Reg.playerLayer.add(player);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER, 1);
		
		super.create();
		Reg.state = this;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(player, walls);
		
		FlxG.collide(walls, Reg.bulletLayer, function(entity:FlxSprite, bullet:Bullet):Void {
			bullet.kill();
		});
	}	
}