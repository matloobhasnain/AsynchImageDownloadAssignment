//
//  Urls.h
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Urls : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *raw;
@property (nonatomic, strong) NSString *full;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *regular;
@property (nonatomic, strong) NSString *small;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
