//
//  BRKBall.m
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

#import "BRKBall.h"

@implementation BRKBall

- (BRKBall *) initWithPosition:(CGPoint) position {

    if((self = [super init])){
        
        bouncyness = 1.0;
        speed = CGPointMake(5.0, 5.0);
        accelleration = 0.0;
        direction = CGPointMake(1.0, 1.0);
        
        
        ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball.png"]];
        self.frame = CGRectMake(position.x, position.y, ballView.frame.size.width, ballView.frame.size.height);
        [self addSubview:ballView];
    }
    
    return self;

}

- (void) update{
    
    //Keep adjusting the ball's position untill a valid one if found.
    while(![self isPositionValid]);
    self.center = [self nextPosition];

}

- (BOOL) isPositionValid {

    if([self isWithinStageBounds]){
        return YES;
    }
    
    return NO;

}

- (BOOL) isWithinStageBounds {
    
    //Check of if the ball is within the bounds of the stage
    
    CGPoint nextPosition = [self nextPosition];

    if(nextPosition.x >= self.superview.frame.origin.x + self.frame.size.width/2 && 
       nextPosition.x + self.frame.size.width/2 <=  self.superview.frame.origin.x+self.superview.frame.size.width){
        if (nextPosition.y >= self.superview.frame.origin.y && 
            nextPosition.y + self.frame.size.height/2 <= self.superview.frame.origin.y + self.superview.frame.size.height) {
            return YES;
        } else { 
            direction.y *= -1;
        }
    
    } else { 
        direction.x *= -1;
    }
    
    return NO;
    
}

- (BOOL) isAboveLifeLine {

    if(self.center.y > kLifeLineY)
        return NO;

    return YES;
}

- (CGPoint) nextPosition {

    return CGPointMake(self.center.x+(speed.x*direction.x), self.center.y+(speed.y*direction.y));
    
}

- (void) bounce {

    direction.x *=1;
    direction.y *=-1;
}

- (void) resetAtPosition:(CGPoint) position {

    self.frame = CGRectMake(position.x, position.y, ballView.frame.size.width, ballView.frame.size.height);
    direction.x=1;
    direction.y=-1;
    bouncyness = 1.0;
    accelleration = 0.0;
}

@end
