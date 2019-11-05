package tictac.logic;

import js.lib.Int16Array;
import js.lib.Object;
import js.Browser;
import react.React;
import react.ReactDOM;
import react.ReactComponent;
import react.ReactMacro.jsx;

class Board extends ReactComponent {
    public function new(props)
	{
		super();
        this.state = {
        squares: [for (i in 0...9) null],
        xIsNext: true,
        player: props.value,
        choosePlayer: props.choosePlayer,
        winner: null,
        vischpl: 'hidden' 
        };
        if (this.state.player == "O")
        {
        var ai = new AI(this.state.squares, "X");
        this.state.squares[ai.makeMove()] = "X";
        }
    }
    function Square(props)
    {
        return jsx('
        <button className = "square"
        onClick = {props.onClick}
        >
                    {props.value}
                </button>
        ');
    }
    function clickToChoosePlayer()
    {
         this.state.choosePlayer();
    }
    function handleClick(i)
    {
        var squares_ = this.state.squares.slice(0);
        var playerMark:String = this.state.player;
        var aiMark:String = playerMark =="X" ? "O" : "X";
        if (CalculateWinner.calculateWinner(this.state.squares) !=null || this.state.squares[i] != null) 
        {
            return;
        }
        squares_[i] = playerMark;
        var ai = new AI(squares_, aiMark);
        squares_[ai.makeMove()] = aiMark;
        setState({
            squares: squares_,
            });
        if (CalculateWinner.calculateWinner(squares_)!=null)
        {
            this.setState({vischpl:'visible'});
        }
    }
    public function renderSquare(i:Int):ReactElement {
        return jsx("
		<Square 
        value=${this.state.squares[i]}
        onClick = {() -> this.handleClick(i)}>
        </Square>
		");
	}
    override public function render():ReactElement 
    {
        var winner = CalculateWinner.calculateWinner(this.state.squares);
        var status:String;
        if(winner!=null && winner != 'draw')
        {
            status= "The winner is " + winner;
        }
        else if(winner == 'draw')
        {
            status = "Draw";
        }
        else
        {
            
            status = 'Next player: ' + (this.state.xIsNext ? "X" : "O");
        }
        return jsx("
        <div>
            <div>
                <div>
                    <div className='status'>{status}
                    </div>
                </div>
                <div className='board-row'>
                    {this.renderSquare(0)}
                    {this.renderSquare(1)}
                    {this.renderSquare(2)}
                </div>
                <div className='board-row'>
                    {this.renderSquare(3)}
                    {this.renderSquare(4)}
                    {this.renderSquare(5)}
                </div>
                <div className='board-row'>
                    {this.renderSquare(6)}
                    {this.renderSquare(7)}
                    {this.renderSquare(8)}
                </div>
            </div>
            <button onClick = {()-> this.clickToChoosePlayer()} style = {{visibility:this.state.vischpl}}>Next game</button>
            </div>
        ");
    }
}

class Game extends ReactComponent {
    function stateGame(player:String)
    {
        this.setState({curState:1, player:player});
    }
    function stateChoosePlayer()
    {
        this.setState({curState:0});
    }
    public function CurrentState(){
        switch(this.state.curState){
            case (0):
            return jsx("
            <div>
            <button className='square' onClick={() -> this.stateGame('X')}>X</button>
            <button className='square' onClick={() -> this.stateGame('O')}>O</button>
            </div>
            ");
            case(1):
            return jsx("
            <Board value = ${this.state.player} choosePlayer ={this.stateChoosePlayer}></Board>
            ");
        }
        return jsx('<div/>');
    }
  override function render():ReactElement {
    var s = "X";
    return jsx("
            <div className='game'> 
                    <div className='game-board'>
                        <CurrentState></CurrentState>
                    </div>
                    <div className='game-info'>
                    </div>
            </div>
    ");
    }
  public function new()
	{
		super();
        this.state = {
            curState: 0,
            player:''
        };
    }
}