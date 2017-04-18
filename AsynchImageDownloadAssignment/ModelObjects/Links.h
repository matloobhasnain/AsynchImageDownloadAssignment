//
//  Links.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Links : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *photos;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) NSString *download;
@property (nonatomic, strong) NSString *linksSelf;
@property (nonatomic, strong) NSString *html;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
