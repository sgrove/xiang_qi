
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Team.h"
#import "Piece.h"
#import "Board.h"

// HelloWorld Layer
@interface XiangQi : Layer
{
	Board *board;
	
	// Initialize teams
	Team *team_1;
	Team *team_2;
	bool pieceSelected;
	NSArray *teams;
	
	Piece *selectedPiece;
	NSString *currentTeam;
}


+(id) scene;
@property (nonatomic, retain) Board *board;
@property (nonatomic, retain) Piece *selectedPiece;
@end
