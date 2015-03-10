//
//  MapTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/3/9.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "MapTableViewCell.h"

@implementation MapTableViewCell 

- (void)awakeFromNib {
    // Initialization code
    
    // Create a location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Ask for permission (only one)
    //[self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    self.mapView.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    if ([region.description isEqualToString:@"Rio"]) {
        if (state == CLRegionStateInside) {
            NSLog(@"Already in Rio");
        }
    }
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Exit Regions:%@",region);
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Goodbye";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Enter region:%@",region);
    UILocalNotification * notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Hello";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}



///-----------------------------------------------------------------------------
#pragma mark - Location Manager Delegate Methods
///-----------------------------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations: %@", [locations lastObject]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager error: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
        status == kCLAuthorizationStatusAuthorizedAlways) {
        
        // Configure location manager
        [self.locationManager setDistanceFilter:kCLHeadingFilterNone];//]500]; // meters
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager setHeadingFilter:kCLDistanceFilterNone];
        self.locationManager.activityType = CLActivityTypeFitness;
        
        // Start the location updating
        [self.locationManager startUpdatingLocation];
        
        // Start beacon monitoring
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc]
                                                                                initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"]
                                                                    identifier:@"Estimotes"];
        [manager startRangingBeaconsInRegion:region];
        
        // Start region monitoring for Rio
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(-22.903,-43.2095);
        CLCircularRegion *bregion = [[CLCircularRegion alloc] initWithCenter:coordinate
                                                                      radius:100
                                                                  identifier:@"Rio"];
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        [self.locationManager startMonitoringForRegion:bregion];
        
        
        // Show map
        self.mapView.showsUserLocation = YES;
        self.mapView.showsPointsOfInterest = YES;
        CLLocation *userLoc = self.mapView.userLocation.location;
        [self.mapView setCenterCoordinate:userLoc.coordinate animated:YES];
        
    } else if (status == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                        message:@"This app needs you to authorize locations services to work."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"Wrong location status");
    }
}

-(MKAnnotationView *) mapView:(MKMapView *)mapsView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%@ %@",view,control);
}


@end
