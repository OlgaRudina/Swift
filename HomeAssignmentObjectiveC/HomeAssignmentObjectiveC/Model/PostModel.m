//
//  PostModel.m
//  HomeAssignmentObjectiveC
//
//  Created by Olga Rudina on 2021-03-31.
//

#import "PostModel.h"

@implementation PostModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (void)setDictionary:(NSDictionary *)dictionary{
    self.desc = dictionary[@"description"] ? : @"";
    self.title = dictionary[@"title"] ? : @"";
    self.upvotes = dictionary[@"upvotes"] ? : 0;
    self.numComments = dictionary[@"numComments"] ? : 0;
    self.imageURL = dictionary[@"imageURL"] ? : @"";
}

@end
