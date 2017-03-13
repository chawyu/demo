//
//  MessageBaseCell.m
//  iOSDemo
//
//  Created by 周维 on 17/3/4.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageBaseCell.h"
#import "MessageEntity.h"
#import "UserEntity.h"
#import "UserMng.h"
#import <Masonry/Masonry.h>

@implementation MessageBaseCell
CGFloat const ct_avatarEdge = 10;                 //头像到边缘的距离
CGFloat const ct_avatarBubbleGap = 5;             //头像和气泡之间的距离
CGFloat const ct_bubbleUpDown = 20;                //气泡到上下边缘的距离
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userType = BubbleType_Left;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.userContent = [[UILabel alloc] initWithFrame:CGRectZero];
      
        self.userAvater = [[UIImageView alloc] init];
        [self.userAvater setUserInteractionEnabled:YES];
        [self.userAvater setContentMode:UIViewContentModeScaleAspectFill];
        [self.userAvater setClipsToBounds:YES];
        [self.userAvater.layer setCornerRadius:CGRectGetHeight([self.userAvater bounds]) / 2];
        self.userAvater.layer.borderWidth = 5;
        self.userAvater.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self.contentView addSubview:self.userAvater];
        
        self.userName = [[UILabel alloc] init];
        [self.userName setUserInteractionEnabled:YES];
        [self.contentView addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 15));
            make.top.mas_equalTo(0);
            make.left.equalTo(self.userAvater.mas_right).offset(13);
        }];
        
        self.userBubble = [[UIImageView alloc] init];
        [self.userBubble setUserInteractionEnabled:YES];
        [self.contentView addSubview:self.userBubble];
        
    }
    return self;
}

-(void)setContent:(MessageEntity*)message{
    if (self.userType == BubbleType_Left) {
        [self.userAvater mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(ct_avatarEdge);
        }];
    } else {
        [self.userAvater mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-ct_avatarEdge);
        }];
    }
    //头像名字
    
    UserEntity* user = [[UserMng shareInstance] getUser:message.sourceId];
    if (user) {
        [self.userName setText:user.name];
        [self.userAvater setImage:[UIImage imageNamed:@"my_selected"]];
    }
    
    CGSize size = [self sizeForContent:message];
    CGFloat height = [self contentUpGapWithBubble] + size.height + [self contentDownGapWithBubble];
    CGFloat width = [self contentLeftGapWithBubble] + size.width + [self contentRightGapWithBubble];
    
    if (self.userType == BubbleType_Left) {
        UIImage* bubbleimage = [UIImage imageNamed:@"my_selected"];
        bubbleimage = [bubbleimage stretchableImageWithLeftCapWidth:bubbleimage.size.width*0.5 topCapHeight:bubbleimage.size.width*0.8];
        [self.userBubble mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, height));
            make.left.mas_equalTo(self.userAvater.mas_right).offset(ct_avatarBubbleGap);
            make.top.mas_equalTo(self.userName.mas_bottom).offset(0);
        }];
        
        [self.userBubble setImage:bubbleimage];
    } else {
        UIImage* bubbleimage = [UIImage imageNamed:@"my_selected"];
        bubbleimage = [bubbleimage stretchableImageWithLeftCapWidth:bubbleimage.size.width*0.5 topCapHeight:bubbleimage.size.width*0.8];
        [self.userBubble mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, height));
            make.right.mas_equalTo(self.userAvater.mas_left).offset(-ct_avatarBubbleGap);
            make.top.mas_equalTo(self.userName.mas_bottom).offset(0);
        }];

        [self.userBubble setImage:bubbleimage];
        
    }
    
    
}
#pragma mark  ChatCellProtocol

- (CGSize)sizeForContent:(MessageEntity*)message{
    return CGSizeZero;
}

- (CGFloat)contentUpGapWithBubble{
    return 0;
    
}

- (CGFloat)contentDownGapWithBubble{
    return 0;
    
}

- (CGFloat)contentLeftGapWithBubble{
    return 0;
    
}

- (CGFloat)contentRightGapWithBubble{
    return 0;
    
}

- (void)layoutContentView:(MessageEntity*)message{
    
    
}

- (CGFloat)cellHeightForMessage:(MessageEntity*)message{
    return 0;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
