//
//  BRKBall.h
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
//
//  Created by Tommaso Piazza on 11/4/11.
//

#import "BRKBlock.h"

#define kLifeLineY 440

@interface BRKBall : UIView
{
    UIImageView *ballView;
    CGFloat bouncyness; //Not used.
    CGPoint speed;
    CGFloat accelleration; //Not used.
    CGPoint direction;

}

- (BRKBall *) initWithPosition:(CGPoint) position; //Initiates the ball at a given position.
- (void) update; //Moves the ball accordingly.
- (BOOL) isPositionValid; //Checks for the validity of the ball's position.
- (BOOL) isWithinStageBounds; //Checks if the ball is within the bounds of the stage.
- (BOOL) isAboveLifeLine; //Checks if the ball is above the paddle.
- (CGPoint) nextPosition; //Returns the ball's next position.
- (void) bounce; //Changes the direction of the ball.
- (void) resetAtPosition:(CGPoint) position; //Resets the ball at a given position. 

@end
