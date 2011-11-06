//
//  BRKPaddle.m
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

#import "BRKPaddle.h"

@implementation BRKPaddle

-(BRKPaddle *) init {


    if((self = [super init])){
    
    }

    return self;
}


+ (BRKPaddle *) blockAtPosition:(CGPoint) position withImageNamed:(NSString *) imgName {
    
    return [[BRKPaddle alloc] initAtPosition:position withImageNamed:imgName];
    
}

- (void) resetAtPosition:(CGPoint) position {
    
    self.frame = CGRectMake(position.x, position.y, blockView.frame.size.width, blockView.frame.size.height);
}

@end
