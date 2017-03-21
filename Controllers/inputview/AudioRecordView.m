

#import "AudioRecordView.h"
#import "UIColor+expanded.h"
@interface AudioRecordView () /*<AudioManagerDelegate>*/

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *recordBgView;
@property (nonatomic, strong) UIView *spreadView;
@property (nonatomic, strong) UIView *flashView;
@property (nonatomic, assign) AudioRecordViewTouchState touchState;

@end

@implementation AudioRecordView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    	self.isRecording = NO;

    	self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.image = [UIImage imageNamed:@"keyboard_voice_record"];
        self.imageView.userInteractionEnabled = NO;
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
    NSLog(@"----onTouchDown------------>>>>>>>");
    [self startAnimation];
    //TODO
    if (_delegate && [_delegate respondsToSelector:@selector(recordViewRecordStarted:)]) {
        [_delegate recordViewRecordStarted:self];
    }
}
- (void)onTouchUpInside:(id)sender {
    NSLog(@"----onTouchUpInside------------>>>>>>>");
	[self stopAnimation];
    //TODO
    if (_delegate && [_delegate respondsToSelector:@selector(recordViewRecordFinished:file:duration:)]) {
        [_delegate recordViewRecordFinished:self file:@"" duration:100];
    }
    
}
- (void)onTouchUpOutside:(id)sender {
    NSLog(@"----onTouchUpOutside------------>>>>>>>");
	[self stopAnimation];
    //TODO
    if (_delegate && [_delegate respondsToSelector:@selector(recordViewRecordFinished:file:duration:)]) {
        [_delegate recordViewRecordFinished:self file:@"" duration:100];
    }
    
}
- (void)onTouchDragEnter:(id)sender {
    NSLog(@"----onTouchDragEnter------------>>>>>>>");
    
}
- (void)onTouchDragExit:(id)sender {
    NSLog(@"----onTouchDragExit------------>>>>>>>");
    
}
#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    _touchState = AudioRecordViewTouchStateInside;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //TODO
    if (_delegate && [_delegate respondsToSelector:@selector(recordView:volume:)]) {
        [_delegate recordView:self volume:1];
    }
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    BOOL touchInside = [self pointInside:[touch locationInView:self] withEvent:nil];
    BOOL touchStateChanged = NO;
    if (_touchState == AudioRecordViewTouchStateInside && !touchInside) {
        _touchState = AudioRecordViewTouchStateOutside;
        touchStateChanged = YES;
    }
    else if (_touchState == AudioRecordViewTouchStateOutside && touchInside) {
        _touchState = AudioRecordViewTouchStateInside;
        touchStateChanged = YES;
    }
    if (touchStateChanged) {
        if (_delegate && [_delegate respondsToSelector:@selector(recordView:touchStateChanged:)]) {
            [_delegate recordView:self touchStateChanged:_touchState];
        }
    }
}
#pragma mark - anima
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