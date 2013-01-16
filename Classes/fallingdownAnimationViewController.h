//
//  fallingdownAnimationViewController.h
//  fallingdownAnimation
//
//  Created by jimney on 10-7-24.
//  Copyright jimney 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface fallingdownAnimationViewController : UIViewController
{
	UIImageView* m_pMyImageView;
	CAAnimationGroup* m_pGroupAnimation;
}
- (CAAnimation *)animationRotate;
- (CAAnimation *)animationFallingDown;
- (CAAnimation *)animationShrink;
@end

