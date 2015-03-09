//
//  WriteNoteViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/7.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "WriteNoteViewController.h"

@interface WriteNoteViewController ()

@end

@implementation WriteNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)saveNote:(id)sender {
    NSError * err = nil;
    NSURL *docs =[[NSFileManager new] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];
    NSURL *file = [docs URLByAppendingPathComponent:@"notes.plist"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:file];
    NSArray * notesArray = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * tmp = nil;
    if (notesArray) {
        tmp = [[NSMutableArray alloc] initWithArray:notesArray];
    } else {
        tmp = [[NSMutableArray alloc] init];
    }
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  currenttime=[dateformatter stringFromDate:senddate];
    NSLog(@"123=%@",currenttime);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger year = [comps year];
    NSInteger week = [comps weekday];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    //NSInteger sec = [comps second];
    //NSString *month2;
  
    Note * note = [[Note alloc] init];
    note.content = self.Text.text;
    note.year = [NSString stringWithFormat: @"%ld", (long)year];
    if (month == 1) {
        note.month = [NSString stringWithFormat: @"JAN ,"];
    }
    else if(month == 2){
        note.month = [NSString stringWithFormat: @"FEB ,"];
    }
    else if(month == 3){
        note.month = [NSString stringWithFormat: @"MAR ,"];
    }
    else if(month == 4){
        note.month = [NSString stringWithFormat: @"APR ,"];
    }
    else if(month == 5){
        note.month = [NSString stringWithFormat: @"MAY ,"];
    }
    else if(month == 6){
        note.month = [NSString stringWithFormat: @"JUN ,"];
    }
    else if(month == 7){
        note.month = [NSString stringWithFormat: @"JUL ,"];
    }
    else if(month == 8){
        note.month = [NSString stringWithFormat: @"AUG ,"];
    }
    else if(month == 9){
        note.month = [NSString stringWithFormat: @"SEP ,"];
    }
    else if(month == 10){
        note.month = [NSString stringWithFormat: @"OCT ,"];
    }
    else if(month == 11){
        note.month = [NSString stringWithFormat: @"NOV ,"];
    }
    else if(month == 12){
        note.month = [NSString stringWithFormat: @"DEC ,"];
    }
    //note.month = [NSString stringWithFormat: @"%ld", (long)month];
    if (week == 1) {
        note.week = [NSString stringWithFormat: @"Sunday"];
    }
    else if(week == 2){
        note.week = [NSString stringWithFormat: @"Monday"];
    }
    else if(week == 3){
        note.week = [NSString stringWithFormat: @"Tuesday"];
    }
    else if(week == 4){
        note.week = [NSString stringWithFormat: @"Wednesday"];
    }
    else if(week == 5){
        note.week = [NSString stringWithFormat: @"Thursday"];
    }
    else if(week == 6){
        note.week = [NSString stringWithFormat: @"Friday"];
    }
    else if(week == 7){
        note.week = [NSString stringWithFormat: @"Saturday"];
    }
    //    note.week = [NSString stringWithFormat: @"%ld", (long)week];

    note.date = [NSString stringWithFormat: @"%ld", (long)day];

    note.hour = [NSString stringWithFormat: @"%ld", (long)hour];

    note.minute = [NSString stringWithFormat: @"%ld", (long)min];
    
    [tmp addObject:note];
    
    NSData * notes = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [notes writeToURL:file atomically:NO];
}
@end
