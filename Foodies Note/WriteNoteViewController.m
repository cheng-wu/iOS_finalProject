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
    
    Note * note = [[Note alloc] init];
    note.title = @"test111";
    
    [tmp addObject:note];
    
    NSData * notes = [NSKeyedArchiver archivedDataWithRootObject:tmp];
    [notes writeToURL:file atomically:NO];
}
@end
