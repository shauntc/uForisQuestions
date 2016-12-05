
import Foundation

/////////////////////////
//START String reverser//
/////////////////////////

func reverseString(input:String) -> String {
    //End case for recursion
    if input.isEmpty {
        return input
    }
    
    //Removes last letter from the string
    var newInput = input
    let lastChar = String(stringInterpolationSegment: newInput.characters.popLast()!)
    
    //Returns last letter in front and calls reverse string to reverse the rest of the string
    return lastChar + reverseString(input: newInput)
}


let stringToReverse = "This string will be reversed"


print ("Original String: \(stringToReverse)")
print ("Reversed String: \(reverseString(input: stringToReverse))")
print ("")

///////////////////////
//END String reverser//
///////////////////////

/////////////////////////////////
//START Queens on a chess board//
/////////////////////////////////

//Some constants for simplicity
//Board_Height also determines how man queens will be attempted to be placed
let BOARD_HEIGHT = 8
let BOARD_WIDTH = BOARD_HEIGHT //Set for a square board but this can be changed to a rectangular board
let BOARD_HEIGHT_INDEX = BOARD_HEIGHT - 1
let BOARD_WIDTH_INDEX = BOARD_WIDTH - 1


//Checks if a given position is valid against a set of locations
func isValidQueenPosition(queenLocations:[Int], newLocation:Int) -> Bool {
    
    //If there are no more rows to check returns true (which will cascade back to the initial function call)
    if queenLocations.isEmpty {
        return true
    }
    
    //Checks for conflicts with Queen in the top row of the board
    //This is the end case for recursion if there are conflicts
    if newLocation == queenLocations.first! || newLocation == queenLocations.first! + queenLocations.count || newLocation == queenLocations.first! - queenLocations.count  {
        return false
    }
    
    //Removes the top row and calls self to check the next row
    return isValidQueenPosition(queenLocations: Array(queenLocations.dropFirst()), newLocation: newLocation)
}


//Determines where to place the queens, can be called with an initial position or without (by calling it with an empty array)
func placeQueens(queenLocations:[Int]) -> [Int] {
    
    //Break case for recursion (when it has placed one on each row)
    if queenLocations.count >= BOARD_HEIGHT {
        return queenLocations
    }
    
    
    for column in 0...BOARD_WIDTH_INDEX {
        
        //Checks if the column is a valid position for a queen
        if isValidQueenPosition(queenLocations: queenLocations, newLocation: column) {
            
            //Calls placeQueens to place the next queen
            let board = placeQueens(queenLocations: queenLocations + [column])
            
            //If that returns a valid placement then the configuration is returned
            if board.last! <= BOARD_WIDTH_INDEX && board.last! >= 0 {
                return board
            }
        }
        
        //If a valid configuration for a queen on this column is not found this loop checks the next column
    }
    
    //If a valid solution is not found a -1 is added to the last location as it is not possible at any board size
    return queenLocations + [-1]
}



//Calls Queen placing function Prints the resulting configuration of Queens (And returns an array of strings reprisenting the configuration)
func queensSolver() -> [String] {
    
    //Calls placeQueens with a random starting point (Random point is uneccessary but displays different solutions each time for interests sake, an empty array will ensure finding a solution if one exists)
    let queenLocations = placeQueens(queenLocations: [Int(arc4random_uniform(UInt32(BOARD_WIDTH)))])
    var fullBoard = [String]()
    
    //Checks if a valid solution is found
    if queenLocations.last! == -1 {
        print ("Failed to find a solution")
    }
    //Builds and Prints the board
    else {
        for (row, location) in queenLocations.enumerated() {
            var rowString = ""
            for index in 0...BOARD_WIDTH_INDEX {
                if index == location {
                    rowString += "♛ "
                }else{
                    rowString += "☐ "
                }
            }
            
            print (row.description + " " + rowString)
            fullBoard.append(rowString)
        }
    }
    
    return fullBoard
}

queensSolver()


///////////////////////////////
//END Queens on a chess board//
///////////////////////////////
