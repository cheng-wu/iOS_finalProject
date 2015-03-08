//
//  Note.h
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate * date;

@end
