//
//  MessageBaseCell.m
//  iOSDemo
//
//  Created by 周维 on 17/3/4.
//  Copyright © 2017年 chaw. All rights reserved.
//

#import "MessageBaseCell.h"
#import <Masonry/Masonry.h>

@implementation MessageBaseCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userType = BubbleType_Left;
        self.contentView.backgroundColor = [UIColor clearColor];
      
        self.userAvater = [[UIImageView alloc] init];
        [self.userAvater setUserInteractionEnabled:YES];
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
        }];
    } else {
        [self.userAvater mas_remakeConstraints:^(MASConstraintMaker *make) {
        }];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
