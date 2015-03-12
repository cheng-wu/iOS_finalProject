//
//  PersonalCheckInTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "PersonalCheckInTableViewCell.h"

@implementation PersonalCheckInTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    

    // Configure the view for the selected state
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.FBPicture.profileID = user.objectID;
    self.name.text = user.name;
    NSLog(@"just a test!!!!!!");
}

@end
