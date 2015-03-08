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
    /*
    NSString *test = self.Text.text;
    NSLog(@"test=%@",test);
    
    [super viewDidLoad];
    //读取plist
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"NoteList" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    
    //添加一项内容
    //[data setObject:@"add some content" forKey:@"A"];
    */
    //获取应用程序沙盒的Documents目录
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"NoteList1.plist"];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"NoteList.plist"];
    NSMutableDictionary *data = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]mutableCopy];
    NSLog(@"111111%@", data);
    NSMutableDictionary *info = [data objectForKey:@"初一班"];
    
    NSString *name1 = [info objectForKey:@"name1"];
    
    name1 = @"山山";
    
    [info setValue:name1 forKey:@"name1"];
    [data setValue:info forKey:@"初一班"];
    [data writeToFile:plistPath atomically:YES];
    
    NSLog(@"222222%@", data);
}
@end
