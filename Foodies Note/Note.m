//
//  Note.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/8.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "Note.h"

@implementation Note

// delegate method
- (id) initWithCoder:(NSCoder *) decoder{
    self=[super init];
    self.title = [decoder decodeObjectForKey:@"title"];
    self.content = [decoder decodeObjectForKey:@"content"];
    self.link = [decoder decodeObjectForKey:@"link"];
    self.year = [decoder decodeObjectForKey:@"year"];
    self.month = [decoder decodeObjectForKey:@"month"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.week = [decoder decodeObjectForKey:@"week"];
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.link forKey:@"link"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.year forKey:@"year"];
    [encoder encodeObject:self.month forKey:@"month"];
    [encoder encodeObject:self.week forKey:@"week"];
}

@end
