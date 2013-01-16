//
//  fallingdownAnimationAppDelegate.h
//  fallingdownAnimation
//
//  Created by jimney on 10-7-24.
//  Copyright jimney 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fallingdownAnimationViewController;

@interface fallingdownAnimationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    fallingdownAnimationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet fallingdownAnimationViewController *viewController;

@end

