package tictac.logic;

import js.lib.Int16Array;
import haxe.ds.List;

class AI
{
    var localBoard:Array<String>;
    var aiSeed:String;
    var oppSeed:String;
    final ROWS:Int = 9;
    final COLS:Int = 9;
    final VERYBIGNUMBER:Int = 999999999;
    public function new(globalBoard:Array<String>, signOfAi:String)
    {
        aiSeed = signOfAi;
        oppSeed = signOfAi == "X"? "O":"X";
        this.localBoard = globalBoard.slice(0);
    }
    public function makeMove():Int
    {
        var result:Int = minimax(3, this.aiSeed)[0];//_minimax(10,this.aiSeed);
        return result;
    }
    /*private function minimax(playerSeed:String):Int
    {
        var move = -1;
        var score = -1;
        var nextMoves:haxe.ds.List<Int> = generateMoves();
        for (i in nextMoves)
        {
            localBoard[i] = playerSeed;
            var scoreForTheMove = -minimax(playerSeed==aiSeed?oppSeed:aiSeed);
            if (scoreForTheMove > score)
            {
                score = scoreForTheMove;
                move = i;
            }
        }
        return 0;
    }*/
    private function minimax(depth:Int, playerSeed:String):Array<Int>
    {
        var nextMoves:haxe.ds.List<Int> = generateMoves();
        var bestScore = (playerSeed == aiSeed) ? -VERYBIGNUMBER: VERYBIGNUMBER;
        var currentScore:Int;
        var bestMove:Int=-1;
        if (nextMoves.isEmpty() || depth == 0)
        {
            bestScore = evaluate();
        }
        else
        {
            //var _move:Int = 0;
            for (move in nextMoves){
            //move = move;
                localBoard[move] = playerSeed;
                if(playerSeed == aiSeed)
                {
                    currentScore = minimax(depth-1, oppSeed)[1];
                    trace("Current score ai " + currentScore);
                    
                    if (currentScore>bestScore)
                    {
                        bestScore = currentScore;
                        bestMove = move; 
                    }
                }
                else 
                    {
                        currentScore = minimax(depth-1, aiSeed)[1];
                        trace("Current score opp" + currentScore);
                        if (currentScore < bestScore)
                        {
                            bestScore = currentScore;
                            bestMove = move;
                        }
                    }
                localBoard[move] = null;
                trace(bestMove, bestScore);
            }
        }
        return [bestMove, bestScore];
    }
    private function generateMoves():List<Int>
    {
        var nextMoves:List<Int> = new List<Int>();
        if(CalculateWinner.calculateWinner(localBoard) == aiSeed || CalculateWinner.calculateWinner(localBoard) == oppSeed)
        {
            return nextMoves;
        }
        for (i in 0...9)
        {
            if (localBoard[i] == null)
            nextMoves.add(i);
        }
        return nextMoves;
    }
    private function evaluate()
    {
        var score = 0;
        score += evaluateLine(0,1,2);
        score += evaluateLine(3,4,5);
        score += evaluateLine(6,7,8);
        score += evaluateLine(0, 3, 6);
        score += evaluateLine(1, 4, 7);
        score += evaluateLine(2, 5, 8);
        score += evaluateLine(0, 4, 8);
        score += evaluateLine(2, 4, 6);
        return score;
    }
    private function evaluateLine(posOne:Int, posTwo:Int, posThree:Int):Int
    {
        var score =0;
        if (localBoard[posOne] == aiSeed)
        {
            score = 1;
        }
        else if (localBoard[posOne] == oppSeed)
        {
            score = -1;
        }

        if (localBoard[posTwo] == aiSeed)
        {
            if(score == 1)
            {
                score = 10;
            }
            else if(score == -1)
            {
                return 0;
            }
            else {
                score = 1;
            }
        }
        else if (localBoard[posTwo] == oppSeed)
        {
            if(score == -1)
            {   
                score=-10;
            }
            else if(score == 1)
            {
                return 0;
            }
            else{
                score =-1;
            }
        }
        if (localBoard[posThree] == aiSeed)
        {
            if(score > 0)
            {
                score *=10;
            }
            else if(score < 0)
            {
                return 0;
            }
            else {
                score = 1;
            }
        }
        else if (localBoard[posThree] == oppSeed)
        {
            if(score < 0)
            {   
                score*=10;
            }
            else if(score > 1)
            {
                return 0;
            }
            else{
                score =-1;
            }
        }
        return score;
    }
}