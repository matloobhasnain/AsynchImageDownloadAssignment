//
//  Categories.m
//
//  Created by   on 17/04/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Categories.h"
#import "Links.h"


NSString *const kCategoriesId = @"id";
NSString *const kCategoriesTitle = @"title";
NSString *const kCategoriesPhotoCount = @"photo_count";
NSString *const kCategoriesLinks = @"links";


@interface Categories ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Categories

@synthesize categoriesIdentifier = _categoriesIdentifier;
@synthesize title = _title;
@synthesize photoCount = _photoCount;
@synthesize links = _links;


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
            self.categoriesIdentifier = [[self objectOrNilForKey:kCategoriesId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kCategoriesTitle fromDictionary:dict];
            self.photoCount = [[self objectOrNilForKey:kCategoriesPhotoCount fromDictionary:dict] doubleValue];
            self.links = [Links modelObjectWithDictionary:[dict objectForKey:kCategoriesLinks]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoriesIdentifier] forKey:kCategoriesId];
    [mutableDict setValue:self.title forKey:kCategoriesTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.photoCount] forKey:kCategoriesPhotoCount];
    [mutableDict setValue:[self.links dictionaryRepresentation] forKey:kCategoriesLinks];

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

    self.categoriesIdentifier = [aDecoder decodeDoubleForKey:kCategoriesId];
    self.title = [aDecoder decodeObjectForKey:kCategoriesTitle];
    self.photoCount = [aDecoder decodeDoubleForKey:kCategoriesPhotoCount];
    self.links = [aDecoder decodeObjectForKey:kCategoriesLinks];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_categoriesIdentifier forKey:kCategoriesId];
    [aCoder encodeObject:_title forKey:kCategoriesTitle];
    [aCoder encodeDouble:_photoCount forKey:kCategoriesPhotoCount];
    [aCoder encodeObject:_links forKey:kCategoriesLinks];
}

- (id)copyWithZone:(NSZone *)zone
{
    Categories *copy = [[Categories alloc] init];
    
    if (copy) {

        copy.categoriesIdentifier = self.categoriesIdentifier;
        copy.title = [self.title copyWithZone:zone];
        copy.photoCount = self.photoCount;
        copy.links = [self.links copyWithZone:zone];
    }
    
    return copy;
}


@end
