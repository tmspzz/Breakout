//
//  BRKStage.h
//  Breakout
//
//
// This file is part of Breakout.
// 
// Breakout is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Breakout is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with Breakout.  If not, see <http://www.gnu.org/licenses/>.
//
//  Created by Tommaso Piazza on 11/4/11.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BRKPaddle.h"
#import "BRKBall.h"
#import "BRKBlock.h"

#define kBlocksMax 30 //The maximum number of blocks in the game
#define kScoreStep 100
#define kLivesMax 3
#define kBlockLine 300 //Y below witch allow block respawn

@interface BRKStageViewController : UIViewController
{
    int score;
    int lives;
    BOOL gameOver;
    NSMutableArray *blocks;
    BRKPaddle *paddle;
    BRKBall *ball;
    CADisplayLink *displayLink; //A timer called each time the display needs redrawing, 60 times a seconds

}

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *livesLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (strong, nonatomic) IBOutlet UILabel *playToRestartLabel;
@property (strong, nonatomic) IBOutlet UIButton *playPauseButton;



- (void) gameLoop:(CADisplayLink *) sender; // The main loop
- (void) spawnBlocks; //Used to spawn the blocks
- (void) updateScore;
- (int) updateLives;
- (IBAction) playPause;
- (void) pause;
- (void) gameOver;

@end
