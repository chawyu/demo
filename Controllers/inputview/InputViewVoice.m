


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

@interface InputViewVoice ()<AudioRecordViewDelegate>
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
        self.recordLabel.textColor = [UIColor colorWithHexString: @"0x999999"];
        self.recordLabel.text = @"按住说话";
        //self.recordLabel.numberOfLines = 1;
        //self.recordLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:self.recordLabel];

        self.tipLabel = [[UILabel alloc] init];
        self.tipLabel.font = [UIFont systemFontOfSize:12];
        self.tipLabel.text = @"向上滑动，取消发送";
        self.tipLabel.textColor = [UIColor colorWithRGBHex:0x999999];
        self.tipLabel.numberOfLines = 1;
       // self.tipLabel.backgroundColor = [UIColor greenColor];
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
        self.recordView = [[AudioRecordView alloc] initWithFrame:CGRectMake(0,0, kAudioRecordViewWidth, kAudioRecordViewWidth)];
       // self.recordView = [[AudioRecordView alloc] initWithFrame:self.bounds];
        self.recordView.delegate = self;
        //self.recordView.backgroundColor = [UIColor redColor];
        [self addSubview:self.recordView];
        
        
        
        [self.recordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(self.mas_top).offset(kPaddingLeftWidth);
            make.centerX.equalTo(self.mas_centerX).offset(0);
           // make.size.mas_equalTo(CGSizeMake(self.bounds.size.width ,self.bounds.size.height));
            
        }];
        [self.recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.mas_centerY).offset(0);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.size.mas_equalTo(CGSizeMake(kAudioRecordViewWidth ,kAudioRecordViewWidth));
        }];
         [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            // make.size.mas_equalTo(CGSizeMake(self.bounds.size.width ,self.bounds.size.height));
            
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-kPaddingLeftWidth);;
        }];
        
        
        //self.backgroundColor = [UIColor orangeColor];



    	}

    return self;
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
            self.recordLabel.textColor = [UIColor colorWithRGBHex:0x2faeea];
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
    //[self.recordLabel sizeToFit];
    
     [self.recordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
     
     make.top.mas_equalTo(self.mas_top).offset(kPaddingLeftWidth);
     make.centerX.equalTo(self.mas_centerX).offset(0);
     // make.size.mas_equalTo(CGSizeMake(self.bounds.size.width ,self.bounds.size.height));
     
     }];

	if (_status == InputViewVoiceStatus_Recording) {
        //self.volumeLeftView.center = CGPointMake(_recordTipsLabel.frame.origin.x - _volumeLeftView.frame.size.width/2 - 12, _recordTipsLabel.center.y);
        self.volumeLeftView.hidden = NO;
       // self.volumeRightView.center = CGPointMake(_recordTipsLabel.frame.origin.x + _recordTipsLabel.frame.size.width + _volumeRightView.frame.size.width/2 + 12, _recordTipsLabel.center.y);
        self.volumeRightView.hidden = NO;
        [self.volumeLeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAudioVolumeViewWidth, kAudioVolumeViewHeight));
            make.right.mas_equalTo(self.recordLabel.mas_left).offset(-kPaddingLeftWidth);
            make.top.mas_equalTo(self.recordLabel.mas_top);
        }];
         [self.volumeRightView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAudioVolumeViewWidth, kAudioVolumeViewHeight));
            make.left.mas_equalTo(self.recordLabel.mas_right).offset(kPaddingLeftWidth);
             make.top.mas_equalTo(self.recordLabel.mas_top);
        }];
    }
    NSLog(@"=>%@",NSStringFromCGRect(self.volumeLeftView.frame));
}
#pragma mark - RecordTimer

- (void)startTimer {
    self.duration = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(increaseRecordTime) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        self.timer = nil;
    }
}

- (void)increaseRecordTime {
    self.duration++;
    if (self.status == InputViewVoiceStatus_Recording) {
        //update time label
        self.status = InputViewVoiceStatus_Recording;
        NSLog(@"TIME-->%.2d", self.duration);
    }
}
- (NSString *)formattedTime:(int)duration {
    return [NSString stringWithFormat:@"%02d:%02d", duration / 60, duration % 60];
}
#pragma mark - AudioRecordViewDelegate

- (void)recordViewRecordStarted:(AudioRecordView *)recordView {
    [_volumeLeftView clearVolume];
    [_volumeRightView clearVolume];
    self.status = InputViewVoiceStatus_Recording;
    [self startTimer];
}

- (void)recordViewRecordFinished:(AudioRecordView *)recordView file:(NSString *)file duration:(NSTimeInterval)duration {
    [self stopTimer];
    if (self.status == InputViewVoiceStatus_Recording) {
        //TODO
//        if (_recordSuccessfully) {
//            _recordSuccessfully(file, duration);
//        }
    }
    else if (self.state == InputViewVoiceStatus_Cancel) {
        //remove record file TODO
//        [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    }
    self.status = InputViewVoiceStatus_Ready;
    _duration = 0;
}

- (void)recordView:(AudioRecordView *)recordView touchStateChanged:(AudioRecordViewTouchState)touchState {
    if (self.state != InputViewVoiceStatus_Recording) {
        if (touchState == AudioRecordViewTouchStateInside) {
            self.status = InputViewVoiceStatus_Recording;
        }
        else {
            self.status = InputViewVoiceStatus_Cancel;
        }
    }
}

- (void)recordView:(AudioRecordView *)recordView volume:(double)volume {
    [_volumeLeftView addVolume:volume];
    [_volumeRightView addVolume:volume];
    NSLog(@"---recodeing---%.2f", volume);
}

- (void)recordViewRecord:(AudioRecordView *)recordView err:(NSError *)err {
    [self stopTimer];
    if (self.status == InputViewVoiceStatus_Recording) {
        //TODO
        //[NSObject showHudTipStr:err.domain];
    }
    self.status = InputViewVoiceStatus_Ready;
    _duration = 0;
}
@end