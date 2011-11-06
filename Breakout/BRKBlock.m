//
//  BRKBlock.m
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

@implementation BRKBlock

- (BRKBlock *) initAtPosition:(CGPoint) position {

    if((self = [super init])){
        maxHealth = (arc4random()%kBlockMaxHealth)+1; //No Zero health Blocks
        currentHealth = maxHealth;
        blockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"block_%d.png", maxHealth]]];
        self.frame = CGRectMake(position.x, position.y, blockView.frame.size.width, blockView.frame.size.height);
        [self addSubview:blockView];
        //NSLog(@"%@", [NSString stringWithFormat:@"block_%d.png", maxHealth]);
    }
    
    return self;

}

- (BRKBlock *) initAtPosition:(CGPoint) position withImageNamed:(NSString *) imgName {
    
    if((self = [super init])){
        
        maxHealth = (arc4random()%kBlockMaxHealth)+1; //No Zero health Blocks
        currentHealth = maxHealth;
        blockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        self.frame = CGRectMake(position.x, position.y, blockView.frame.size.width, blockView.frame.size.height);
        [self addSubview:blockView];
    }
    
    return self;
    
}


+ (BRKBlock *) blockAtPosition:(CGPoint) position {

    return [[BRKBlock alloc] initAtPosition:position];
    
}

+ (BRKBlock *) blockAtPosition:(CGPoint) position withImageNamed:(NSString *) imgName {
    
    return [[BRKBlock alloc] initAtPosition:position withImageNamed:imgName];
    
}

- (BOOL) isImpactWithBallAtPosition:(CGPoint) ballPosition {

    
    //Check for a ball impact.
    
    if(ballPosition.y > self.center.y - self.frame.size.height/2 && 
       ballPosition.y < self.center.y + self.frame.size.height/2){
        
        if(ballPosition.x > self.center.x - self.frame.size.width/2 && 
           ballPosition.x < self.center.x + self.frame.size.width/2){
            
            return HIT;
            
        }
    }
    
    return NO_HIT;
}

- (int) update{
    
    currentHealth--;
    //Add the cracks.
    blockView.image = [self addImage:blockView.image toImage:[UIImage imageNamed:@"cracks.png"] withAlpha:(1-(1/maxHealth)*currentHealth)];

    return currentHealth; 

}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 withAlpha:(CGFloat) alpha {
	UIGraphicsBeginImageContext(image1.size);
    
	// Draw image1
	[image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    
	// Draw image2
	[image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height) blendMode:kCGBlendModeMultiply alpha:alpha];
    
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return resultingImage;
}

@end
