//
//  BRKBlock.h
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

#import <Foundation/Foundation.h>

#define HIT YES
#define NO_HIT NO
#define kBlockMaxHealth 4
#define kBlockHeight 20
#define kBlockWidth 60

@interface BRKBlock : UIView
{
    
    UIImageView *blockView;
    short int maxHealth;
    short int currentHealth;

}

- (BOOL) isImpactWithBallAtPosition:(CGPoint) ballPosition; //Checks for block-ball impact.
- (int) update; //Updates the position of the ball accordingly.
//Utility function to blend images.
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 withAlpha:(CGFloat) alpha;
//Allocates a block and sets its position.
+ (BRKBlock *) blockAtPosition:(CGPoint) position;
//Allocates a block with a particular image and sets its position.
+ (BRKBlock *) blockAtPosition:(CGPoint) position withImageNamed:(NSString *) imgName;
- (BRKBlock *) initAtPosition:(CGPoint) position;
- (BRKBlock *) initAtPosition:(CGPoint) position withImageNamed:(NSString *) imgName;

@end
