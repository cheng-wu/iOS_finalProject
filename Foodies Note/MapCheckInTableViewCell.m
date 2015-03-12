//
//  MapCheckInTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/11.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "MapCheckInTableViewCell.h"
#import "YelpListing.h"

@implementation MapCheckInTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"checkin.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * articleArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (articleArray) {
        tmp = [[NSMutableArray alloc] initWithArray:articleArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    for (YelpListing * yelp in tmp) {
        NSLog(@"not here??");
        NSString *latitude = [yelp.coordinate valueForKey:@"latitude"];
        NSString *longitude = [yelp.coordinate valueForKey:@"longitude"];
        
        NSLog(@"location=%@",latitude);
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
        annotation.title = yelp.name;
        annotation.subtitle = yelp.display_phone;
        [self.mapView addAnnotation:annotation];
        
        MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [latitude floatValue];
        region.center.longitude = [longitude floatValue];
        region.span.longitudeDelta = 1.8f;
        region.span.longitudeDelta = 1.8f;
        [self.mapView setRegion:region animated:YES];
        [self.mapView setCenterCoordinate:region.center animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
