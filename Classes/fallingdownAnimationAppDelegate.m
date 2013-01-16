//
//  fallingdownAnimationAppDelegate.m
//  fallingdownAnimation
//
//  Created by jimney on 10-7-24.
//  Copyright jimney 2010. All rights reserved.
//

#import "fallingdownAnimationAppDelegate.h"
#import "fallingdownAnimationViewController.h"

@implementation fallingdownAnimationAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
