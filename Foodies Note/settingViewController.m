//
//  settingViewController.m
//  Foodies Note
//
//  Created by kaiyuan duan on 15/3/12.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "settingViewController.h"
#import "HowtouseViewController.h"

@interface settingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation settingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    // Do any additional setup after loading the view.
    [self drawTableView];
}
-(void)drawTableView{
    UITableView *tview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [tview setDelegate:self];
    [tview setDataSource:self];
    [self.view addSubview:tview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1||section == 2) {
        return 2;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
            case 0:
                cell.textLabel.text =  @"My Account";
                break;
            case 1:
                if(row == 0)
                {
                    cell.textLabel.text =  @"General";
                }else{
                    cell.textLabel.text =  @"Privacy";
                }
                break;
            case 2:
                if(row == 0)
                {
                    cell.textLabel.text =  @"About";
                }else{
                    cell.textLabel.text =  @"Instructions for Use";
                }
                break;
            case 3:
                cell.textLabel.text =  @"Log out";
                break;
            default:
                break;
        }
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if(section==2&&row==1){
        //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HowtouseViewController* howtouseview = [storyboard instantiateViewControllerWithIdentifier:@"howtouseview"];
        
        
        [self.navigationController pushViewController:howtouseview animated:YES];
    }
    
}





@end
