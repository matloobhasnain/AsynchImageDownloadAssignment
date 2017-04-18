//
//  Categories.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Links;

@interface Categories : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double categoriesIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double photoCount;
@property (nonatomic, strong) Links *links;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
