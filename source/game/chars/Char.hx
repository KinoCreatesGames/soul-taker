package game.chars;

class Char extends FlxSprite {
	public var name:String;
	public var atk:Int;
	public var def:Int;

	public function new(x:Float, y:Float, data:Actor) {
		super(x, y);
		this.name = data.name;
		this.atk = data.atk;
		this.def = data.def;
		this.health = data.health;
	}

	public function takeDamage(damage:Int) {
		health -= damage;
		if (health <= 0) {
			kill();
		}
	}
}