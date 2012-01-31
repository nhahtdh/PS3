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

@implementation ViewController

@synthesize gameObjects;
@synthesize gameArea;
@synthesize pallete;
@synthesize wolfImageArea;
@synthesize mainView;


- (id) init {
    NSLog(@"init called.");
    if (self = [super init]) {
        gameObjects = [NSMutableArray array];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"initWithCoder called.");
    if (self = [super initWithCoder:aDecoder]) {
        gameObjects = [NSMutableArray array];
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"initWithNibName called.");
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
    
    [gameArea setHidden:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    GameWolf* gameWolf = [storyboard instantiateViewControllerWithIdentifier:@"GameWolf"];
    
    [gameObjects addObject: gameWolf];
    
    // pallete = [[UIScrollView alloc] init];
    
    if ([mainView self]) {
        NSArray *arr = [mainView subviews];
        NSLog(@"Number of views %d\n", arr.count);
        for (id item in arr) {
            NSLog(@"%@", [item description]);
        }
    }
    
    if ([pallete self])
        NSLog(@"Pallete exists");
    [pallete addSubview: gameWolf.view];
    [gameArea addSubview: gameWolf.view];
    NSLog(@"%@", gameWolf.view);
}

- (void)viewDidUnload
{
    [self setGameArea:nil];
    [self setWolfImageArea:nil];
    [self setPallete:nil];
    [self setMainView:nil];
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
