//
//  AsynchImageDownloadAssignmentTests.m
//  AsynchImageDownloadAssignmentTests
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utililities.h"
#import "HomeVC.h"
#import <OCMock/OCMock.h>
@interface AsynchImageDownloadAssignmentTests : XCTestCase
@property (nonatomic, strong) HomeVC *homeVCObj;
@end

@implementation AsynchImageDownloadAssignmentTests


- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.homeVCObj = [storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.homeVCObj performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
//
- (void)tearDown
{
    [super tearDown];
    self.homeVCObj = nil;
}



//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testValidUrl
{
    
    NSMutableArray *validUrlsArray = [NSMutableArray arrayWithObjects:@"http://example.com",
                                      @"https://example.com",
                                      @"http://example.com/dir/file.php?var=moo",
                                      @"http://xn--h1aehhjhg.xn--d1acj3b",
                                      @"ttp://142.42.1.1:8080",
                                      @"https://pastebin.com/raw/wgkJgazE",nil];
    
    NSMutableArray *inValidUrlsArray = [NSMutableArray arrayWithObjects:@"localhost",
                                      @"yandex.",
                                      @"hкоряга",
                                      @"hhttp:///a",
                                      @"ftps://foo.bar/",
                                      @"hrdar://1234",nil];
    
    for(NSString *urlString in validUrlsArray)
    {
        if ([Utililities validateUrl:urlString])
        {
            NSAssert(true, @"its Valid Url");
        }
    }
    
    for(NSString *urlString in inValidUrlsArray)
    {
        if ([Utililities validateUrl:urlString])
        {
            NSAssert(false, @"its invalid Url");
        }
    }
    
    
    
}

-(void)testAspectRatio
{

    float height = [Utililities getImageHeightAccordingToAspectRatio:320 WithSorceImageHeight:480 WithNewWidth:400];
    if(height == 600)
    {
        NSAssert(true, @"its Valid height according to ratio");
    }
    
    height = [Utililities getImageHeightAccordingToAspectRatio:320 WithSorceImageHeight:470 WithNewWidth:400];
    if(height == 600)
    {
        NSAssert(false, @"its not Valid height according to ratio");
    }
    
    height = [Utililities getImageHeightAccordingToAspectRatio:400 WithSorceImageHeight:800 WithNewWidth:600];
    if(height == 1200)
    {
        NSAssert(true, @"its  Valid height according to ratio");
    }

    
}


#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.homeVCObj.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.homeVCObj.view.subviews;
    XCTAssertTrue([subviews containsObject:self.homeVCObj.tbl_ImagesList], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.homeVCObj.tbl_ImagesList, @"TableView not initiated");
}


#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.homeVCObj conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.homeVCObj.tbl_ImagesList.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.homeVCObj conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.homeVCObj.tbl_ImagesList.delegate, @"Table delegate cannot be nil");
}




- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    
}

#pragma mark - Invoking Tests

-(void)testInvokefetchJsonResponseFromServer
{
    
    HomeVC *object = [[HomeVC alloc] init];
    // create a partial mock for that object
    id mock = [OCMockObject partialMockForObject:object];
    // tell the mock object what you expect
    [[mock expect] fetchJsonResponseFromServer];
    // call the actual method on the mock object
    [mock fetchJsonResponseFromServer];
    // and finally verify
    [mock verify];
    
}

-(void)testInvokeRefreshControllAdding
{
    
    HomeVC *object = [[HomeVC alloc] init];
    // create a partial mock for that object
    id mock = [OCMockObject partialMockForObject:object];
    // tell the mock object what you expect
    [[mock expect] addRefreshControl];
    // call the actual method on the mock object
    [mock addRefreshControl];
    // and finally verify
    [mock verify];
    
}

@end
