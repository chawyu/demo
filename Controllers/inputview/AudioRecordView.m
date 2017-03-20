

#import "AudioRecordView.h"
#import "UIColor+expanded.h"
@interface AudioRecordView () /*<AudioManagerDelegate>*/

@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, assign) AudioRecordViewTouchState touchState;

@property (nonatomic, strong) UIView *recordBgView;
@property (nonatomic, strong) UIView *spreadView;
@property (nonatomic, strong) UIView *flashView;

@end

@implementation AudioRecordView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    	self.isRecording = NO;

    	self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = [UIImage imageNamed:@"keyboard_voice_record"];
        self.imageView.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
/*
        self.spreadView = [[UIView alloc] initWithFrame:CGRectMake(-8, -8, self.frame.size.width+16, self.frame.size.height+16)];
        self.spreadView.backgroundColor = kColorCommonBG;
        self.spreadView.layer.cornerRadius = self.spreadView.frame.size.width/2;
        self.spreadView.alpha = 0;
        [self addSubview:self.spreadView];

        self.flashView = [[UIView alloc] initWithFrame:self.bounds];
        self.flashView.backgroundColor = [UIColor whiteColor];
        self.flashView.layer.cornerRadius = self.flashView.frame.size.width/2;
        self.flashView.alpha = 0;
        [self addSubview:self.flashView];
*/
        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        /*
        [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(onTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(onTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
         */
        NSLog(@"=========%d", self.enabled);
    }
    return self;
}
// 当用户点击到当前控件bounds时，会调用该方法，返回值决定了当前控件是否响应该事件
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"beginTrackingWithTouchstate=[%zd]", self.state);
    
    return YES;
    //    return NO;
    //    return [super beginTrackingWithTouch:touch withEvent:event]; // 返回系统默认处理
}

// 如果 beginTrackingWithTouch 返回值 为YES，则以下方法 会在 点击手机屏幕移动 时 调用，如果这里返回值为YES，则继续移动会多次调用。
// 如果 返回 NO，则 即使 继续移动也不会再调用当前方法了。
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"continueTrackingWithTouchstate=[%zd]", self.state);
    
    // 这里发送 点击 事件时，外部会调用 对应的事件处理方法
    //    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    return YES;
    //    return NO;
    //    return [super beginTrackingWithTouch:touch withEvent:event];  // 返回系统默认处理
}

// 当点击屏幕释放时，调用该方法
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"endTrackingWithTouchstate=[%zd]", self.state);
    [super endTrackingWithTouch:touch withEvent:event];  // 系统默认处理
}

// 取消时会调用，如果当前视图被移除。或者来电
- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-event=[%@]", __FUNCTION__, event);
    NSLog(@"scancelTrackingWithEventtate=[%zd]", self.state);
    [super cancelTrackingWithEvent:event];  // 系统默认处理
}

- (void)onTouchDown:(id)sender {
    NSLog(@"----33333------------>>>>>>>");
   // [self startAnimation];
}
- (void)onTouchUpInside:(id)sender {
	[self stopAnimation];
    
}
- (void)onTouchUpOutside:(id)sender {
	[self stopAnimation];
    
}
- (void)onTouchDragEnter:(id)sender {
    
}
- (void)onTouchDragExit:(id)sender {
    
}
- (void)startAnimation {
   // _recordBgView.hidden = NO;
    self.spreadView.alpha = 1.0f;
    self.spreadView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    self.flashView.alpha = 0.4f;
    
    [UIView beginAnimations:@"RecordAnimation" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationRepeatCount:FLT_MAX];
    
    self.flashView.alpha = 0;
    self.spreadView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    self.spreadView.alpha = 0;
    
    [UIView commitAnimations];
}
- (void)stopAnimation {
    [self.flashView.layer removeAllAnimations];
    [self.spreadView.layer removeAllAnimations];
    
   // _recordBgView.hidden = YES;
    self.spreadView.alpha = 0;
    self.flashView.alpha = 0;
}
@end