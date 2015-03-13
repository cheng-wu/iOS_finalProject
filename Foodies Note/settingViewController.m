//
//  settingViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *DataTable;
    
    NSMutableArray *dataArray1;
    
    NSMutableArray *dataArray2;
    
    NSMutableArray *titleArray;
    
}

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 600)];
    
    [DataTable setDelegate:self];
    
    [DataTable setDataSource:self];
    
    [self.view addSubview:DataTable];
    
    
    
    dataArray1 = [[NSMutableArray alloc] initWithObjects:@"中国", @"美国", @"英国", nil];
    dataArray2 = [[NSMutableArray alloc] initWithObjects:@"黄种人", @"黑种人", @"白种人", nil];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"国家", @"种族", nil];    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    // Return YES for supported orientations
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return [titleArray objectAtIndex:section];
        case 1:
            return [titleArray objectAtIndex:section];
        default:
            return @"Unknown";
            
    }  
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
    
}

//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            return  [dataArray1 count];
            break;
        case 1:
            return  [dataArray2 count];
            break;
        default:
            return 0;
            break;  
            
    }  
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            [[cell textLabel]  setText:[dataArray1 objectAtIndex:indexPath.row]];
            break;
        case 1:
            [[cell textLabel]  setText:[dataArray2 objectAtIndex:indexPath.row]];
            break;
            default:
            [[cell textLabel]  setText:@"Unknown"];
    }  
    
    return cell;
    
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

@end
