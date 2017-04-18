//
//  NetworkLayer.m
//  AsynchImageDownloadAssignment
//
//  Created by Apple on 17/04/2017.
//  Copyright © 2017 terabyteLogixs. All rights reserved.
//

#import "NetworkLayer.h"
#import "AppDelegate.h"
#import "Utililities.h"
@implementation NetworkLayer



+ (id)sharedNetworkLayer
{
    static NetworkLayer *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
   
    self = [super init];
    return self;
}

- (void)dealloc
{

}

-(void)getResponseWithSourceObject:(id)sourceObject WithApiEndPoint:(NSString*)endPoint WithParams:(NSDictionary*)params
{
    
    // its a generic method for all get type api you just need to send parametters and end point of an api and parsing would be done on the base of end points.

    if([Utililities validateUrl:BASE_URL])
    {
        NSURL *URL = [NSURL URLWithString:BASE_URL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/plain"];
        [self showHUD];
        
        // here we are using afnetworking for network calls , because afnetworking bases on NSURLCache so we just need to set
        //cache policy and it will provides us cachy automatticaly , we have set cache capcity and other params in app delegate
        // didfinish launching.
        
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
         {
             [self removeHUD];
             NSMutableArray *responseArray = (NSMutableArray*)responseObject;
             NSMutableArray *baseClassArray = [NSMutableArray array];
             
             for(int i = 0; i<responseArray.count;i++)
             {
                 BaseClass *baseClassObj = [BaseClass modelObjectWithDictionary:[responseArray objectAtIndex:i]];
                 [baseClassArray addObject:baseClassObj];
                 
             }
             // we assuming here the response would be success every time, because we dont have all format of this api response se we are not checking here any status code.
             NSError *error;
             NSDictionary *resultantDict = [[NSDictionary alloc]initWithObjectsAndKeys:baseClassArray,@"dataArray",
                                            @"Success",@"Status",nil];
             
             self.networkLayerDelegate = sourceObject;
             if ([self.networkLayerDelegate respondsToSelector:@selector(from_NLGetImagesList:response:withError:)])
             {
                 [self.networkLayerDelegate from_NLGetImagesList:sourceObject response:resultantDict withError:error];
             }
             
             
             
         }
             failure:^(NSURLSessionTask *operation, NSError *error)
         {
             [self removeHUD];
             NSLog(@"Error: %@", error);
             
             NSDictionary *resultantDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                                            @"Failure",@"Status",nil];
             
             self.networkLayerDelegate = sourceObject;
             if ([self.networkLayerDelegate respondsToSelector:@selector(from_NLGetImagesList:response:withError:)])
             {
                 [self.networkLayerDelegate from_NLGetImagesList:sourceObject response:resultantDict withError:error];
             }
             
             
         }];

    }
    
}


#pragma mark - MBProgressHUD Methods
- (void)showHUD
{
    [self removeHUD];
    UIWindow * window = APP_DELEGATE.window;
    self.HUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:self.HUD];
    //[window setUserInteractionEnabled:NO];
    self.HUD.label.text = @"Loading";
    self.HUD.detailsLabel.text = @"Please wait";
    [self.HUD showAnimated:YES];
}

- (void)removeHUD {
    
    [self.HUD hideAnimated:YES];
    [self.HUD removeFromSuperview];
    //[APP_DELEGATE.window setUserInteractionEnabled:YES];
}


@end
