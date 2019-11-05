package tictac.logic;

class CalculateWinner
{
    static private var winnerLines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
    ];
    public static function calculateWinner(squares:Array<String>):String
    {
    for (i in 0...(winnerLines.length))
    {
        var firstSquare:Int = winnerLines[i][0];
        var secondSquare:Int = winnerLines[i][1];
        var thirdSquare:Int = winnerLines[i][2];
        if (
        squares[firstSquare] != null &&
        squares[firstSquare] == squares[secondSquare] && 
        squares[firstSquare] == squares[thirdSquare]
        )
        {
            return squares[firstSquare];
        }
    } 
    for (i in squares)
    {
        if (i == null)
        return null;
    }
    return "draw";
    }  
}