


#import "InputViewVoice.h"
#import "AudioRecordView.h"
#import "AudioVolumeView.h"
#import <Masonry/Masonry.h>
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
        self.recordLabel.numberOfLines = 1;
        [self addSubview:self.recordLabel];

        self.tipLabel = [[UILabel alloc] init];
        self.tipLabel.font = [UIFont systemFontOfSize:12];
        self.tipLabel.text = @"向上滑动，取消发送";
        self.tipLabel.numberOfLines = 1;
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
        self.recordView.delegate = self;
        [self addSubview:self.recordView];
        [self.recordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.view.mas_top).offset(0);
            make.centerX.equalTo(self.view).offset(0);
            make.bottom.mas_equalTo(self.recordView.top);
        }];
        [self.recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.recordLabel.mas_bottom).offset(0);
            make.centerX.equalTo(self.view).offset(0);
            make.bottom.mas_equalTo(self.tipLabel.top);
        }];
         [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            //make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(self.recordView.mas_top).offset(0);
            make.centerX.equalTo(self.view).offset(0);
            make.bottom.mas_equalTo(self.view.bottom);
        }];


    	}
    return self;
}

- (void)setStatus:(InputViewVoiceStatus)status {
	self.status = status;
	switch (status){
		case InputViewVoiceStatus_Ready:
			self.recordLabel.textColor = [UIColor colorWithRGBHex:0x999999];
            self.recordLabel.text = @"按住说话";
            self.volumeRightView.hidden = YES;
            self.volumeLeftView.hidden = YES;
			break;
		case InputViewVoiceStatus_Recording:
			self.recordLabel.text = [self formattedTime:self.duration];
			break;
		case InputViewVoiceStatus_Cancel:
			self.recordLabel.textColor = [UIColor colorWithRGBHex:0x999999];
            self.recordLabel.text = @"松开取消";
            self.volumeRightView.hidden = YES;
            self.volumeLeftView.hidden = YES;
			break;
		default:

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
@end