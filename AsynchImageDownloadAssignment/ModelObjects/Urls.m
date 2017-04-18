//
//  Urls.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Urls.h"


NSString *const kUrlsRaw = @"raw";
NSString *const kUrlsFull = @"full";
NSString *const kUrlsThumb = @"thumb";
NSString *const kUrlsRegular = @"regular";
NSString *const kUrlsSmall = @"small";


@interface Urls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Urls

@synthesize raw = _raw;
@synthesize full = _full;
@synthesize thumb = _thumb;
@synthesize regular = _regular;
@synthesize small = _small;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.raw = [self objectOrNilForKey:kUrlsRaw fromDictionary:dict];
            self.full = [self objectOrNilForKey:kUrlsFull fromDictionary:dict];
            self.thumb = [self objectOrNilForKey:kUrlsThumb fromDictionary:dict];
            self.regular = [self objectOrNilForKey:kUrlsRegular fromDictionary:dict];
            self.small = [self objectOrNilForKey:kUrlsSmall fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.raw forKey:kUrlsRaw];
    [mutableDict setValue:self.full forKey:kUrlsFull];
    [mutableDict setValue:self.thumb forKey:kUrlsThumb];
    [mutableDict setValue:self.regular forKey:kUrlsRegular];
    [mutableDict setValue:self.small forKey:kUrlsSmall];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.raw = [aDecoder decodeObjectForKey:kUrlsRaw];
    self.full = [aDecoder decodeObjectForKey:kUrlsFull];
    self.thumb = [aDecoder decodeObjectForKey:kUrlsThumb];
    self.regular = [aDecoder decodeObjectForKey:kUrlsRegular];
    self.small = [aDecoder decodeObjectForKey:kUrlsSmall];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_raw forKey:kUrlsRaw];
    [aCoder encodeObject:_full forKey:kUrlsFull];
    [aCoder encodeObject:_thumb forKey:kUrlsThumb];
    [aCoder encodeObject:_regular forKey:kUrlsRegular];
    [aCoder encodeObject:_small forKey:kUrlsSmall];
}

- (id)copyWithZone:(NSZone *)zone
{
    Urls *copy = [[Urls alloc] init];
    
    if (copy) {

        copy.raw = [self.raw copyWithZone:zone];
        copy.full = [self.full copyWithZone:zone];
        copy.thumb = [self.thumb copyWithZone:zone];
        copy.regular = [self.regular copyWithZone:zone];
        copy.small = [self.small copyWithZone:zone];
    }
    
    return copy;
}


@end
