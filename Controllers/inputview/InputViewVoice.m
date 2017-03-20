


#import "InputViewVoice.h"
#import "AudioRecordView.h"
#import "AudioVolumeView.h"
#import "UIColor+expanded.h"
#import <Masonry/Masonry.h>
#import "UIColor+expanded.h"
typedef NS_ENUM(NSInteger, InputViewVoiceStatus) {
    InputViewVoiceStatus_Ready,
    InputViewVoiceStatus_Recording,
    InputViewVoiceStatus_Cancel
};

@interface InputViewVoice ()
@property (assign, nonatomic) InputViewVoiceStatus status;
@property (assign, nonatomic) int duration;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILabel *recordLabel;
@property (strong, nonatomic) UILabel *tipLabel; 
@property (strong, nonatomic) AudioVolumeView *volumeRightView; 
@property (strong, nonatomic) AudioVolumeView *volumeLeftView; 
@property (strong, nonatomic) AudioRecordView *recordView;
@end

@implementation InputViewVoice
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    	self.duration = 0;
    	self.backgroundColor = kColorCommonBG;
    	self.status = InputViewVoiceStatus_Ready;

    	self.recordLabel = [[UILabel alloc] init];
        self.recordLabel.font = [UIFont systemFontOfSize:18];
        self.recordLabel.text = @"向上滑动!!!!";
        self.recordLabel.numberOfLines = 1;
        self.recordLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:self.recordLabel];

        self.tipLabel = [[UILabel alloc] init];
        self.tipLabel.font = [UIFont systemFontOfSize:12];
        self.tipLabel.text = @"向上滑动，取消发送";
        self.tipLabel.numberOfLines = 1;
        self.tipLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:self.tipLabel];

        self.volumeRightView = [[AudioVolumeView alloc] initWithFrame:CGRectMake(0, 0, kAudioVolumeViewWidth, kAudioVolumeViewHeight)];
        self.volumeRightView.type = AudioVolumeViewType_Right;
        self.volumeRightView.hidden = YES;
        [self addSubview:self.volumeRightView];
        
        self.volumeLeftView = [[AudioVolumeView alloc] initWithFrame:CGRectMake(0, 0, kAudioVolumeViewWidth, kAudioVolumeViewHeight)];
        self.volumeLeftView.type = AudioVolumeViewType_Left;
        self.volumeLeftView.hidden = YES;
        [self addSubview:self.volumeLeftView];

        //self.recordView = [[AudioRecordView alloc] initWithFrame:CGRectMake((self.frame.size.width - 86) / 2, 62, 86, 86)];
        //self.recordView = [[AudioRecordView alloc] initWithFrame:CGRectMake(0,0, kAudioRecordViewWidth, kAudioRecordViewWidth)];
        self.recordView = [[AudioRecordView alloc] initWithFrame:self.bounds];
        self.recordView.delegate = self;
        self.recordView.backgroundColor = [UIColor redColor];
        [self addSubview:self.recordView];
        /*
        [self.recordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(self.mas_top).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.bottom.mas_equalTo(self.recordView.mas_top);
        }];
        [self.recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.recordLabel.mas_bottom).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
           // make.bottom.mas_equalTo(self.tipLabel.mas_top);
        }];
         [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.recordView.mas_bottom).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
         */
        
        self.backgroundColor = [UIColor orangeColor];



    	}
    [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"----999999999---------->>>>>>>");
}
// 当用户点击到当前控件bounds时，会调用该方法，返回值决定了当前控件是否响应该事件
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"1beginTrackingWithTouchstate=[%zd]", self.state);
    return YES;
    //    return NO;
     // return [super beginTrackingWithTouch:touch withEvent:event]; // 返回系统默认处理
}

// 如果 beginTrackingWithTouch 返回值 为YES，则以下方法 会在 点击手机屏幕移动 时 调用，如果这里返回值为YES，则继续移动会多次调用。
// 如果 返回 NO，则 即使 继续移动也不会再调用当前方法了。
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"1continueTrackingWithTouchstate=[%zd]", self.state);
    
    // 这里发送 点击 事件时，外部会调用 对应的事件处理方法
    //    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    return YES;
    //    return NO;
    //    return [super beginTrackingWithTouch:touch withEvent:event];  // 返回系统默认处理
}

// 当点击屏幕释放时，调用该方法
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-touch=[%@]-event=[%@]", __FUNCTION__, touch, event);
    NSLog(@"1endTrackingWithTouchstate=[%zd]", self.state);
    [super endTrackingWithTouch:touch withEvent:event];  // 系统默认处理
}

// 取消时会调用，如果当前视图被移除。或者来电
- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    //    NSLog(@"%s-event=[%@]", __FUNCTION__, event);
    NSLog(@"1scancelTrackingWithEventtate=[%zd]", self.state);
    [super cancelTrackingWithEvent:event];  // 系统默认处理
}
- (void)onTouchDown:(id)sender {
    NSLog(@"--------------222222-->>>>>>>");
    //[self startAnimation];
}

- (void)setStatus:(InputViewVoiceStatus)status {
	_status = status;
	switch (status){
		case InputViewVoiceStatus_Ready:
			self.recordLabel.textColor = [UIColor colorWithHexString: @"0x999999"];
            self.recordLabel.text = @"按住说话";
            self.volumeRightView.hidden = YES;
            self.volumeLeftView.hidden = YES;
			break;
		case InputViewVoiceStatus_Recording:
			self.recordLabel.text = [self formattedTime:self.duration];
			break;
		case InputViewVoiceStatus_Cancel:
			self.recordLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
            self.recordLabel.text = @"松开取消";
            self.volumeRightView.hidden = YES;
            self.volumeLeftView.hidden = YES;
			break;
		default:
            break;

	} 
	self.recordLabel.center = CGPointMake(self.frame.size.width/2, 20);
	if (status == InputViewVoiceStatus_Recording) {
        //self.volumeLeftView.center = CGPointMake(_recordTipsLabel.frame.origin.x - _volumeLeftView.frame.size.width/2 - 12, _recordTipsLabel.center.y);
        self.volumeLeftView.hidden = NO;
       // self.volumeRightView.center = CGPointMake(_recordTipsLabel.frame.origin.x + _recordTipsLabel.frame.size.width + _volumeRightView.frame.size.width/2 + 12, _recordTipsLabel.center.y);
        self.volumeRightView.hidden = NO;
        [self.volumeLeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.mas_equalTo(self.recordView.mas_left).offset(0);
        }];
         [self.volumeRightView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.recordView.mas_right).offset(0);
        }];
    }
}
- (NSString *)formattedTime:(int)duration {
    return [NSString stringWithFormat:@"%02d:%02d", duration / 60, duration % 60];
}
@end