//
//  BRKStage.m
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

#import "BRKStageViewController.h"

@implementation BRKStageViewController
@synthesize scoreLabel, livesLabel, playPauseButton, gameOverLabel, playToRestartLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(gameLoop:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self playPause];

    if (self) {
        // Custom initialization
        score = 0;
        lives = kLivesMax;
        gameOver = NO;
        
        blocks = [NSMutableArray arrayWithCapacity:kBlocksMax];
        
        [self spawnBlocks];
        
        paddle = (BRKPaddle *)[BRKPaddle blockAtPosition:CGPointMake(110, 400) withImageNamed:@"paddle.png"];
        [self.view addSubview:paddle];
        ball = [[BRKBall alloc ] initWithPosition:CGPointMake(150, 380)];
        [self.view addSubview:ball];
    }
    return self;
}

- (void) spawnBlocks{
    
    /* 
     Startin at y 50 add each block to stage view.
     Starting at x 10, every 5 blocks start a new block line.
     */

    int y = 50;
    for(int i = 0; i < kBlocksMax; i++){
        
        if(i%5 == 0) y+=kBlockHeight;
        
        BRKBlock *aBlock = [BRKBlock blockAtPosition:CGPointMake((10+i*kBlockWidth)%300,y)];
        
        aBlock.tag = i;
        [self.view addSubview:aBlock];
        [blocks addObject:aBlock];
        
    }

}

-(void)gameLoop:(CADisplayLink *) sender {
    
    if([ball isAboveLifeLine]){ //Check if the ball isn't below the paddles.
        
        CGPoint nextPosition =  [ball nextPosition]; //Get the ball's next position.
        
        //If the are no blocks left and the ball is below the spawn line then spawn new blocks.
        if([blocks count] == 0 && nextPosition.y > kBlockLine){
        
            [self spawnBlocks];
        }
        
        if([paddle isImpactWithBallAtPosition:nextPosition]) //If the ball will impact the paddle
            [ball bounce]; //Change the direction of the ball for the next update.
        
        for(BRKBlock *block  in blocks){
            
            //Check is the ball will hit a block
            if([block isImpactWithBallAtPosition:nextPosition]){
                
                //If the block has zero health remove it.
                if([block update] == 0 ){
                    
                    [blocks removeObject:block];
                    [block removeFromSuperview];
                    [self updateScore];
                }
                [ball bounce];
                break; //Jump out of the for loop on impact.
            }
        }
        
        [ball update]; //Move the ball.
    }
    else {
        //The ball is below the paddle.
        if([self updateLives] == 0){ //if no lives left game over
        
            [self gameOver];
            
        } else {
        
            //Puse the game and reset the ball
            [self playPause];
            [ball resetAtPosition:CGPointMake(150, 380)];
            [paddle resetAtPosition:CGPointMake(110, 400)];
        
        }
    
    }

}

- (void)updateScore {

    score +=kScoreStep;
    scoreLabel.text = [NSString stringWithFormat:@"%d", score];

}

- (int)updateLives {
    
    lives--;
    livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    return lives;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /*
    Called for each touch on the stage's view
    move the paddle a the touch's position
    unless the game is paused.
     */
    
    if(!displayLink.isPaused){
    
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:self.view];
        paddle.center = CGPointMake(location.x, paddle.center.y);
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesBegan:touches withEvent:event];
}

- (IBAction)playPause {
    
    //On resume form game over hide the labels.
    if(gameOver){
        gameOverLabel.hidden = YES;
        playToRestartLabel.hidden = YES;
    }

    displayLink.paused = !displayLink.paused;
    [playPauseButton setImage:[UIImage imageNamed:displayLink.isPaused ? @"play.png" : @"pause.png"] forState:UIControlStateNormal];
}

- (void)pause {
    
    displayLink.paused = YES;
    [playPauseButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}

- (void) gameOver {

    /*
     On Game Over display the labels, pause the game, resed ball and paddle, respawn the blocks,
     reset lives and score.
     */
    
    gameOverLabel.hidden = NO;
    playToRestartLabel.hidden = NO;
    gameOver = YES;
    [self pause];
    [ball resetAtPosition:CGPointMake(150, 380)];
    [paddle resetAtPosition:CGPointMake(110, 400)];
    [self spawnBlocks];
    score = 0;
    scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    lives = kLivesMax;
    livesLabel.text = [NSString stringWithFormat:@"%d", lives];


}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
	// to fix the controller showing under the status bar
	self.view.frame = [[UIScreen mainScreen] applicationFrame];
    livesLabel.text = [NSString stringWithFormat:@"%d", lives];
    gameOverLabel.hidden = YES;
    playToRestartLabel.hidden = YES;
}

@end
