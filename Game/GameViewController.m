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

@synthesize inPlayGameObjects;
@synthesize gameArea;

@synthesize palette;
@synthesize paletteGameObjects;

/*
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
 
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)setUpPalette {
    // TODO: Redesign this later
    CGPoint center = CGPointMake(20, palette.bounds.size.height / 2);
    
    // Add Wolf icon to the palette
    GameWolf *gameWolf = [[GameWolf alloc] init];
    [self addChildViewController: gameWolf]; // Not sure whether this is OK or not...
    [paletteGameObjects addObject: gameWolf];
    
    [gameWolf.view setCenter: CGPointMake(center.x + gameWolf.defaultIconSize.width / 2, center.y)];
    [gameWolf scaleToFitWidth: gameWolf.defaultIconSize.width height: gameWolf.defaultIconSize.height];
    center = CGPointMake(center.x + gameWolf.defaultIconSize.width + 20, center.y);
    
    // Add Pig icon to the palette
    GamePig *gamePig = [[GamePig alloc] init];
    [self addChildViewController: gamePig];
    [paletteGameObjects addObject: gamePig];
    
    [gamePig.view setCenter: CGPointMake(center.x + gamePig.defaultIconSize.width / 2, center.y)];
    [gamePig scaleToFitWidth: 100. height: 100.];
    center = CGPointMake(center.x + gamePig.defaultIconSize.width + 20, center.y);
    
    // Add Block icon to the palette
    GameBlock *gameBlock = [[GameBlock alloc] init];
    [self addChildViewController: gameBlock];
    [paletteGameObjects addObject: gameBlock];
    
    [gameBlock.view setCenter:CGPointMake(center.x + gameBlock.defaultIconSize.width / 2, center.y)];
    [gameBlock scaleToFitWidth: 100. height:100.];
    
    [palette addSubview: gameWolf.view];
    [palette addSubview: gamePig.view];
    [palette addSubview: gameBlock.view];
    
    // [palette setExclusiveTouch: YES];
}

- (void) setUpGameArea {
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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    DLog(@"viewDidLoad called");
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    inPlayGameObjects = [NSMutableArray array];
    paletteGameObjects = [NSMutableArray array];
    
    [self setUpGameArea];
    [self setUpPalette];
}

- (void)viewDidUnload
{
    DLog(@"viewDidUnload called");
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

- (IBAction)resetButtonPressed:(id)sender {
    // Clean up all items in the palette and the game area
    for (GameObject* o in inPlayGameObjects) {
        [o.view removeFromSuperview]; 
    }
    inPlayGameObjects = [NSMutableArray array];
    
    for (GameObject* o in paletteGameObjects) {
        [o.view removeFromSuperview];
    }
    paletteGameObjects = [NSMutableArray array];
    
    [self setUpGameArea];
    [self setUpPalette];
}

@end
