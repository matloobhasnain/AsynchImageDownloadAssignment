//
//  BaseClass.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Urls, Links, User;

@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double likes;
@property (nonatomic, strong) Urls *urls;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSArray *currentUserCollections;
@property (nonatomic, strong) Links *links;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) BOOL likedByUser;
@property (nonatomic, strong) User *user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
