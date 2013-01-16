//
//  fallingdownAnimationViewController.m
//  fallingdownAnimation
//
//  Created by jimney on 10-7-24.
//  Copyright jimney 2010. All rights reserved.
//

#import "fallingdownAnimationViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation fallingdownAnimationViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

#define ANIM_ROTATE		@"animationRotate"
#define ANIM_FALLING	@"animationFalling"
#define ANIM_GROUP		@"animationFallingRotate"
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	UIImage* image = [UIImage imageNamed:@"image.png"];
	m_pMyImageView = [[UIImageView alloc] initWithImage:image];
	
	m_pMyImageView.center = CGPointMake(384, 50);
	[self.view addSubview:m_pMyImageView];
	
	//在层上做旋转动画
	CAAnimation* myAnimationRotate	= [self animationRotate];;
	CAAnimation* myAnimationFallingDown		= [self animationFallingDown];;
	CAAnimation* myAnimationShrink			= [self animationShrink];
	
#if 0//method1:依次把各个动画加入层中
	[m_pMyImageView.layer addAnimation:myAnimationRotateForever forKey:ANIM_ROTATE];
	[m_pMyImageView.layer addAnimation:myAnimationFallingDown forKey:ANIM_FALLING];
	
#else//work well :)
	//method2:放入动画数组，统一处理！
	m_pGroupAnimation	= [CAAnimationGroup animation];
	
	//设置动画代理
	m_pGroupAnimation.delegate = self;
	
	m_pGroupAnimation.removedOnCompletion = NO;
	
	m_pGroupAnimation.duration			 = 2.0;
	m_pGroupAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];	
	m_pGroupAnimation.repeatCount		 = 100000;//FLT_MAX;  //"forever";
	m_pGroupAnimation.fillMode			 = kCAFillModeForwards;
	m_pGroupAnimation.animations			 = [NSArray arrayWithObjects:myAnimationRotate, 
																		 myAnimationFallingDown, 
																		 myAnimationShrink,
																		 nil];
	//对视图自身的层添加组动画
	[m_pMyImageView.layer addAnimation:m_pGroupAnimation forKey:ANIM_GROUP];
	
#endif
	
}

//http://boondoggle.atomicwang.org/lemurflip/MFFlipController.m
/*
 *动画结束后的委托函数，移除动画视图
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	//这边为什么是nil? :(
	NSLog(@"anim = %@", [m_pMyImageView.layer valueForKey:ANIM_GROUP]);
#if 1
	//识别动画
	//？debug发现两者的地址不一样，这个问题很纠结
	if ([anim isEqual:m_pGroupAnimation])//[m_pMyImageView.layer valueForKey:ANIM_GROUP])
	{
		NSLog(@"removeFromSuperview...");
		[m_pMyImageView removeFromSuperview];
		[m_pMyImageView release];

	}
#else
	//这种方法，虽然能解决方法，但是处理多个CAAnimationGroup动画或者CAAnimation动画时，就不能有效处理，方法待定
	//这组动画结束，移除视图
	if ([anim isKindOfClass:[CAAnimationGroup class]])
	{
		//这边为什么是nil? :(
		NSLog(@"anim = %@", [m_pMyImageView.layer valueForKey:ANIM_GROUP]);
		
		[m_pMyImageView removeFromSuperview];
		[m_pMyImageView release];

	}
#endif	
}

/*
 * 1、make rotate
 */
- (CAAnimation *)animationRotate
{
	// rotate animation
	CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 1.0, 0, 0.0);
	
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
	animation.toValue		= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration		= 0.5;
	animation.autoreverses	= NO;
    animation.cumulative	= YES;
    animation.repeatCount	= FLT_MAX;  //"forever"
	//设置开始时间，能够连续播放多组动画
	animation.beginTime		= 0.5;
	//设置动画代理
	animation.delegate		= self;

	return animation;
}

/*
 * 2、fall down
 */
- (CAAnimation *)animationFallingDown
{
	//falling down animation:
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
	
	animation.duration				= 2.0;
	animation.autoreverses			= NO;
	animation.removedOnCompletion	= NO;
	animation.repeatCount			= FLT_MAX;  //"forever"
	animation.fromValue				= [NSNumber numberWithInt: 0];
	animation.toValue				= [NSNumber numberWithInt: 1024];
	//设置动画代理
	animation.delegate				= self;

	return animation;
}

/*
 * 3、shrink animation
 */
- (CAAnimation *)animationShrink
{
	
   CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	
    animation.toValue = [NSNumber numberWithDouble:2.0];
	
    animation.duration				= 2.0;
    animation.autoreverses			= YES;
	animation.repeatCount			= FLT_MAX;  //"forever"
	animation.removedOnCompletion	= NO;

	//设置动画代理
	animation.delegate				= self;

	return animation;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
