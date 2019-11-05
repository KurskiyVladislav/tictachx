package tictac;

import js.Browser;
import react.React;
import react.ReactDOM;
import react.ReactComponent;
import react.ReactMacro.jsx;
import tictac.logic.TheGame.Game;

class Tictac extends ReactComponent
{
    public static function main() {
        ReactDOM.render(React.createElement(Game),
        Browser.document.getElementById('root'));
        trace("Start");
    }
    public function new()
	{
		super();
	}
}