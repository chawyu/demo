

#import "AudioRecordView.h"
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
        [self addSubview:self.imageView];

        self.spreadView = [[UIView alloc] initWithFrame:CGRectMake(-8, -8, self.frame.size.width+16, self.frame.size.height+16)];
        self.spreadView.backgroundColor = [UIColor colorWithRGBHex:0xC6ECFD];
        self.spreadView.layer.cornerRadius = self.spreadView.frame.size.width/2;
        self.spreadView.alpha = 0;
        [self addSubview:self.spreadView];

        self.flashView = [[UIView alloc] initWithFrame:self.bounds];
        self.flashView.backgroundColor = [UIColor whiteColor];
        self.flashView.layer.cornerRadius = self.flashView.frame.size.width/2;
        self.flashView.alpha = 0;
        [self addSubview:self.flashView];

        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(onTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(onTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(onTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    }
    return self;
}
- (void)onTouchDown:(id)sender {
    [self startAnimation];
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