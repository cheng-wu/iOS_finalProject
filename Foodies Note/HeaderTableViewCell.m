//
//  HeaderTableViewCell.m
//  Foodies Note
//
//  Created by Cheng Wu on 15/2/27.
//  Copyright (c) 2015年 uchicago. All rights reserved.
//

#import "HeaderTableViewCell.h"

@implementation HeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.width = screenWidth;
    NSLog(@"width=@%f",self.width);
    self.height = 160;
    
    //初始化scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    //self.scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(self.width * 2, self.height);
    self.scrollView.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(70,70);
    UIEdgeInsets top = {10,10,10,10};
    flowLayout.sectionInset = top;
    
    UICollectionView *firstView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
    firstView.backgroundColor = [UIColor whiteColor];
    //注册
    [firstView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"firstCellId"];
    firstView.tag = 10001;
    firstView.delegate   = self;
    firstView.dataSource = self;
    
    UICollectionView *secondView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
    secondView.backgroundColor = [UIColor whiteColor];
    //注册
    [secondView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"secondCellId"];
    secondView.tag = 10002;
    secondView.delegate   = self;
    secondView.dataSource = self;
    
    [_scrollView addSubview:firstView];
    [_scrollView addSubview:secondView];
    
    //初始化pageControl
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
    //self.pageControl.frame=CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20);
    _pageControl.backgroundColor = [UIColor whiteColor];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 2;
    _pageControl.userInteractionEnabled = YES;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    //添加一条线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-0.5, self.width, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    [self addSubview:line];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.width = screenWidth;
    self.height = 160;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        NSLog(@"test=%f",screenWidth);
        
        //初始化scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.width * 2, self.height);
        _scrollView.delegate = self;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(60,60);
        UIEdgeInsets top = {20,30,20,30};
        flowLayout.sectionInset = top;
        
        UICollectionView *firstView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
        firstView.backgroundColor = [UIColor whiteColor];
        //注册
        [firstView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"firstCellId"];
        firstView.tag = 10001;
        firstView.delegate   = self;
        firstView.dataSource = self;
        
        UICollectionView *secondView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.width, 0, self.width, self.height+20) collectionViewLayout:flowLayout];
        secondView.backgroundColor = [UIColor whiteColor];
        //注册
        [secondView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"secondCellId"];
        secondView.tag = 10002;
        secondView.delegate   = self;
        secondView.dataSource = self;
        
        [_scrollView addSubview:firstView];
        [_scrollView addSubview:secondView];
        
        //初始化pageControl
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_scrollView.bounds.size.height,self.bounds.size.width,20)];
        _pageControl.backgroundColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.userInteractionEnabled = YES;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        //添加一条线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 180.0-0.5, self.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        [self addSubview:line];
        
    }
    return self;
}

#pragma mark-
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.bounds.size.width;
    // 在滚动超过页面宽度的50%的时候，切换到新的页面
    int page = floor(_scrollView.contentOffset.x / pageWidth);
    _pageControl.currentPage = page;
    self.flag = page;
    //NSLog(@"qqq=%d",page);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = nil;
    NSInteger index = 0;
    if (collectionView.tag == 10001)
    {
        identify = @"firstCellId";
        index = 1;
        //NSLog(@"123");
    }
    else
    {
        identify = @"secondCellId";
        index = 9;
        //NSLog(@"124");
        //self.flag=1;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld.png",(indexPath.row + index)]]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger iconnumber;
    iconnumber = self.flag*8 + indexPath.row;
    NSLog(@"lalala=%ld",(long)iconnumber);
    if(iconnumber == 0)
    {
        [self.discover getRestaurantsByTerm:@"pizza" islonglat:NO];
    }
    if(iconnumber == 1)
    {
        [self.discover getRestaurantsByTerm:@"chinese" islonglat:NO];
    }
    if(iconnumber == 2)
    {
        [self.discover getRestaurantsByTerm:@"thai" islonglat:NO];
    }
    if(iconnumber == 3)
    {
        [self.discover getRestaurantsByTerm:@"sushi" islonglat:NO];
    }
    if(iconnumber == 4)
    {
        [self.discover getRestaurantsByTerm:@"mexian" islonglat:NO];
    }
    if(iconnumber == 5)
    {
        [self.discover getRestaurantsByTerm:@"indian" islonglat:NO];
    }
    if(iconnumber == 6)
    {
        [self.discover getRestaurantsByTerm:@"burger" islonglat:NO];
    }
    if(iconnumber == 7)
    {
        [self.discover getRestaurantsByTerm:@"drink" islonglat:NO];
    }
}





//点击进行切换
-(void)changePage:(UIPageControl *)sender
{
    NSInteger page = sender.currentPage;
    [_scrollView setContentOffset:CGPointMake(self.width * page, 0) animated:YES];
}


@end
