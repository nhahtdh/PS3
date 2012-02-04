//
//  ViewController.m
//  Game
//
//  Created by  on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameBlock.h"
#import "GamePig.h"
#import "GameWolf.h"

@implementation GameViewController

@synthesize gameObjects;
@synthesize gameArea;
@synthesize palette;

- (id) init {
    DLog(@"init called.");
    if (self = [super init]) {
        gameObjects = [NSMutableArray array];
    }
    return self;
}
 
- (id) initWithCoder:(NSCoder *)aDecoder {
    DLog(@"initWithCoder called.");
    if (self = [super initWithCoder:aDecoder]) {
        gameObjects = [NSMutableArray array];
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    DLog(@"initWithNibName called.");
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        gameObjects = [NSMutableArray array];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    // load the images into UIImage objects
    UIImage *bgImage = [UIImage imageNamed:@"background.png"];
    UIImage *groundImage = [UIImage imageNamed:@"ground.png"];
    
    // Get the width and height of the two images
    CGFloat backgroundWidth = bgImage.size.width;
    CGFloat backgroundHeight = bgImage.size.height;
    CGFloat groundWidth = groundImage.size.width;
    CGFloat groundHeight = groundImage.size.height;
    
    // Place each of them in an UIImageView
    UIImageView *background = [[UIImageView alloc] initWithImage:bgImage];
    UIImageView *ground = [[UIImageView alloc] initWithImage:groundImage];
    CGFloat groundY = gameArea.frame.size.height - groundHeight;
    CGFloat backgroundY = groundY - backgroundHeight;
    
    // The frame property holds the position and size of the views
    // The CGRectMake methods arguments are : x position, y position, width,
    // height
    background.frame = CGRectMake(0, backgroundY, backgroundWidth, backgroundHeight);
    ground.frame = CGRectMake(0, groundY, groundWidth, groundHeight);
    
    // Add these views as subviews of the gameArea.
    [gameArea addSubview:background];
    [gameArea addSubview:ground];
    
    // Set the content size so that gameArea is scrollable
    // otherwise it defaults to the current window size
    CGFloat gameAreaHeight = backgroundHeight + groundHeight;
    CGFloat gameAreaWidth = backgroundWidth;
    [gameArea setContentSize:CGSizeMake(gameAreaWidth, gameAreaHeight)];
    
    // TODO: Redesign this later
    GameWolf *gameWolf = [[GameWolf alloc] init];
    [gameObjects addObject: gameWolf];
    
    [gameWolf.view setCenter: CGPointMake(70, 62)];
    [gameWolf.view setTransform: CGAffineTransformMakeScale(100./225., 100./150.)];
    
    /*
     UIView *wolfImage = (UIView*) [[gameWolf.view subviews] objectAtIndex: 0];
     DLog(@"%d", [wolfImage isMemberOfClass: [UIImageView class]]);
     
     CGRectLog(gameWolf.view.frame);
     CGRectLog(gameWolf.view.bounds);
     CGRectLog(wolfImage.frame);
     CGRectLog(wolfImage.bounds);
     */
    
    GamePig *gamePig = [[GamePig alloc] init];
    [gameObjects addObject: gamePig];
    
    [gamePig.view setCenter: CGPointMake(190, 62)];
    [gamePig.view setTransform: CGAffineTransformMakeScale(100./55., 100./55.)];
    
    GameBlock *gameBlock = [[GameBlock alloc] init];
    [gameObjects addObject: gameBlock];
    
    [gameBlock.view setCenter: CGPointMake(310, 62)];
    [gameBlock.view setTransform: CGAffineTransformMakeScale(100./50., 100./50.)];
    
    [palette addSubview: gameWolf.view];
    [palette addSubview: gamePig.view];
    [palette addSubview: gameBlock.view];
    
    
    // UIGestureRecognizer panGestureRecognizer = [UIGestureRecognizer alloc] initWithTarget:<#(id)#> action:<#(SEL)#>
}

- (void)viewDidUnload
{
    [self setGameArea:nil];
    [self setPalette:nil];
    [self setPalette:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    return NO;
}

- (IBAction)buttonPressed:(id)sender {
    UIColor *newColor;
    UIButton *button = (UIButton*)sender;
    if ([button titleColorForState:UIControlStateNormal] ==
        [UIColor blackColor]) {
        newColor = [UIColor lightGrayColor];
    } else {
        newColor = [UIColor blackColor];
    }
    [button setTitleColor:newColor forState:UIControlStateNormal];
}
@end
