package;

@:build(buildmac.DepotMacros.buildDepotFile('assets/data/soul.dpo'))
class DepotData {
	public static function getByFn<T>(arr:Array<T>, fn:T -> Bool):T {
		var result = arr.filter(fn);
		if (result != null) {
			return result[0];
		} else {
			return null;
		}
	}
}