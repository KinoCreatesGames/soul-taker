package game.chars;

class Char extends FlxSprite {
	public var name:String;
	public var atk:Int;
	public var def:Int;
	public var agi:Int;
	public var dex:Int;
	public var intl:Int;

	public function new(x:Float, y:Float, data:Actor) {
		super(x, y);
		this.name = data.name;
		this.atk = data.atk;
		this.def = data.def;
		this.agi = data.agi;
		this.dex = data.dex;
		this.intl = data.intl;
		this.health = data.health;
	}

	public function takeDamage(damage:Int) {
		health -= damage;
		if (health <= 0) {
			kill();
		}
	}
}