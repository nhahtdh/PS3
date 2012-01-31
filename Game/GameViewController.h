//
//  ViewController.h
//  Game
//
//  Created by  on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)buttonPressed:(id)sender;

@property (strong, nonatomic) NSMutableArray *gameObjects;

@property (strong, nonatomic) IBOutlet UIScrollView *gameArea;
@property (weak, nonatomic) IBOutlet UIScrollView *pallete;
@property (strong, nonatomic) IBOutlet UIImageView *wolfImageArea;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
